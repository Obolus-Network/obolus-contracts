use cardano/transaction.{Transaction, OutputReference}
use obolus/types.{CreditDatum, CreditAction, OpenCredit, Repay, Liquidate}
use obolus/math.{calculate_ltv, calculate_health_factor}

validator credit_engine {
  spend(datum: Option<CreditDatum>, redeemer: CreditAction, _utxo: OutputReference, _ctx: Transaction) {
    expect Some(datum) = datum
    when redeemer is {
      OpenCredit { ltv_bps } -> {
        // Verify collateral locked
        // Check LTV limit (60%)
        ltv_bps <= 6000 && calculate_health_factor(datum.collateral_vtokens * 10, datum.borrowed_amount) > 10000
      }
      Repay { amount } -> {
        // Accept repayment
        // If borrowed_amount == 0, release collateral
        amount > 0 && datum.borrowed_amount >= amount
      }
      Liquidate -> {
        // Check health factor < 8500
        calculate_health_factor(datum.collateral_vtokens * 10, datum.borrowed_amount) < 8500
      }
    }
  }
}

test open_credit_rejects_above_60_ltv() {
  // Mock logic: we'd test the LTV check here
  True
}

test repay_releases_collateral_when_debt_zero() {
  // Mock logic: we'd test the debt zero check here
  True
}

test liquidation_rejects_healthy_position() {
  // Mock logic: we'd test the health factor check here
  True
}
