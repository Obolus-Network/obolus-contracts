use cardano/transaction.{Transaction, OutputReference}
use obolus/types.{YieldRouterDatum, RouterAction, RouteYield, UpdateDebtPortion}
use aiken/collection/list

// Placeholder for admin and keeper PKHs
const admin_pkh = "admin_placeholder"
const keeper_pkh = "keeper_placeholder"

validator yield_router {
  spend(datum: Option<YieldRouterDatum>, redeemer: RouterAction, _utxo: OutputReference, ctx: Transaction) {
    expect Some(datum) = datum
    when redeemer is {
      RouteYield -> {
        // Only callable by Keeper
        list.has(ctx.extra_signatories, keeper_pkh) && datum.pending_yield > 0
      }
      UpdateDebtPortion { new_bps } -> {
        // Only callable by protocol admin
        list.has(ctx.extra_signatories, admin_pkh) && new_bps <= 10000
      }
    }
  }
}
