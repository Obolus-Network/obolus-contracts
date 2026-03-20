import { KoiosProvider, MeshWallet, MeshTxBuilder } from "@meshsdk/core";
import fs from "fs";

async function deploy() {
  const provider = new KoiosProvider("preprod");
  
  const wallet = new MeshWallet({
    networkId: 0,
    fetcher: provider,
    submitter: provider,
    key: {
      type: "cli",
      payment: "58200fbd4efd1d0d526b910cebe8e440a92cba53659a6319aa20f13747d9d0ce36f1",
      stake: "5820e06d2d53acd0cd1516e464aeaf2f830fb8c593124e7145b2ee9454326e57171d"
    },
  });

  await wallet.init();
  const address = await wallet.getChangeAddress();
  console.log("🚀 Starting Cardano Contract Deployment from:", address);

  const validators = [
    { name: "Vault Core", file: "vault_core.plutus" },
    { name: "Credit Engine", file: "credit_engine.plutus" },
    { name: "vTokens Policy", file: "vtokens_policy.plutus" },
    { name: "Yield Router", file: "yield_router.plutus" }
  ];

  for (const v of validators) {
    console.log(`Checking ${v.name}...`);
    
    let deployed = false;
    while (!deployed) {
        try {
            const utxos = await wallet.getUtxos();
            if (utxos.length === 0) {
                console.log("Waiting for UTxOs to appear...");
                await new Promise(r => setTimeout(r, 10000));
                continue;
            }
            
            const plutusJson = JSON.parse(fs.readFileSync(v.file, "utf8"));
            const scriptCbor = plutusJson.cborHex;
            
            const txBuilder = new MeshTxBuilder({ fetcher: provider });
            const unsignedTx = await txBuilder
              .txOut(address, [{ unit: "lovelace", quantity: "2000000" }])
              .txOutReferenceScript(scriptCbor, "PlutusV3")
              .changeAddress(address)
              .selectUtxosFrom(utxos)
              .complete();
              
            const signedTx = await wallet.signTx(unsignedTx);
            const txHash = await wallet.submitTx(signedTx);
            console.log(`✅ ${v.name} Deployed! TX Hash: ${txHash}`);
            deployed = true;
            
            console.log("Waiting 20s for confirmation...");
            await new Promise(r => setTimeout(r, 20000));
        } catch (e) {
            if (e.message?.includes("ValueNotConservedUTxO") || e.message?.includes("BadInputsUTxO")) {
                console.log("UTxO conflict, waiting 10s...");
                await new Promise(r => setTimeout(r, 10000));
            } else {
                console.error(`Failed to deploy ${v.name}:`, e.message || e);
                throw e;
            }
        }
    }
  }

  console.log("🎉 All deployments finished!");
}

deploy().catch(console.error);
