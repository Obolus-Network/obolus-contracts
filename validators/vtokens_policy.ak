use cardano/transaction.{Transaction, Mint}
use cardano/address.{Script}
use aiken/collection/list

validator vtokens {
  mint(_redeemer: Data, _policy_id: ByteArray, ctx: Transaction) {
    // In V3, the ScriptContext is often just the Transaction itself or simplified.
    // Actually, in Aiken V3, the signature for mint is mint(redeemer, policy_id, transaction)
    
    // In a real scenario, we'd check if the vault_core script is an input.
    list.any(ctx.inputs, fn(input) {
      when input.output.address.payment_credential is {
        Script(_) -> True
        _ -> False
      }
    })
  }
}
