pub fn calculate_ltv(borrowed: Int, collateral_value: Int) -> Int {
  if collateral_value == 0 {
    0
  } else {
    borrowed * 10000 / collateral_value
  }
}

pub fn calculate_health_factor(collateral_value: Int, borrowed: Int) -> Int {
  if borrowed == 0 {
    99999
  } else {
    collateral_value * 10000 / borrowed
  }
}

pub fn calculate_vtokens_to_mint(deposit_amount: Int, current_rate_bps: Int) -> Int {
  deposit_amount * 10000 / current_rate_bps
}

pub fn calculate_withdraw_amount(vtokens: Int, current_rate_bps: Int) -> Int {
  vtokens * current_rate_bps / 10000
}

pub fn split_yield(total_yield: Int, debt_portion_bps: Int) -> (Int, Int) {
  let debt_repayment = total_yield * debt_portion_bps / 10000
  let user_payout = total_yield - debt_repayment
  (debt_repayment, user_payout)
}

test ltv_calculation_correct() {
  calculate_ltv(600, 1000) == 6000
}

test health_factor_returns_99999_when_no_debt() {
  calculate_health_factor(1000, 0) == 99999
}

test split_yield_sums_to_total() {
  let (debt, user) = split_yield(100, 4800)
  debt + user == 100
}
