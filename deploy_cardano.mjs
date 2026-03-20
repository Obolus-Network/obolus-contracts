import { Lucid, Blockfrost } from "lucid-cardano";
import fs from "fs";

async function deploy() {
  const lucid = await Lucid.new(
    new Blockfrost("https://cardano-preprod.blockfrost.io/api/v0", "preprodFzYIfO6BdUE1PvHWIiekgYE1ixMa9XF9"),
    "Preprod"
  );

  const paymentSkey = "58200fbd4efd1d0d526b910cebe8e440a92cba53659a6319aa20f13747d9d0ce36f1";
  lucid.selectWalletFromPrivateKey(paymentSkey);

  console.log("🚀 Starting Cardano Contract Deployment...");

  const validators = [
    { name: "Vault Core", file: "vault_core.plutus" },
    { name: "Credit Engine", file: "credit_engine.plutus" },
    { name: "vTokens Policy", file: "vtokens_policy.plutus" },
    { name: "Yield Router", file: "yield_router.plutus" }
  ];

  for (const v of validators) {
    console.log(`Deploying ${v.name}...`);
    const plutusJson = JSON.parse(fs.readFileSync(v.file, "utf8"));
    
    const script = {
      type: "PlutusV3",
      script: plutusJson.cborHex
    };
    
    const scriptAddress = lucid.utils.validatorToAddress(script);
    console.log(`${v.name} Address: ${scriptAddress}`);
    
    try {
        const tx = await lucid.newTx()
          .payToAddressWithData(scriptAddress, { inline: "" }, { lovelace: 2000000n }, script)
          .complete();
        const signedTx = await tx.sign().complete();
        const txHash = await signedTx.submit();
        console.log(`${v.name} Deployed! TX Hash: ${txHash}`);
    } catch (e) {
        console.error(`Failed to deploy ${v.name}:`, e.message);
    }
  }

  console.log("✅ All deployments processed.");
}

deploy();
