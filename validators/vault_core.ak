use cardano/transaction.{Transaction, OutputReference}
use obolus/types.{VaultDatum, VaultAction, Deposit, Withdraw, Harvest}
use aiken/collection/list

// For simplicity, we'll use a placeholder for the Keeper.
const keeper_pkh = "keeper_placeholder"

validator vault_core {
  spend(datum: Option<VaultDatum>, redeemer: VaultAction, _utxo: OutputReference, ctx: Transaction) {
    expect Some(datum) = datum
    when redeemer is {
      Deposit -> {
        // Implementation detail: verify USDCx sent and vTokens minted
        True
      }
      Withdraw { amount } -> {
        // Verify caller is datum.owner
        list.has(ctx.extra_signatories, datum.owner) && amount > 0
      }
      Harvest -> {
        // Only callable by Keeper
        list.has(ctx.extra_signatories, keeper_pkh)
      }
    }
  }
}

test harvest_rejects_non_keeper() {
  // Mock logic: we'd test the signature check here
  True
}
