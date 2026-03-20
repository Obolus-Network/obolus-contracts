use obolus/math.{calculate_health_factor}

pub fn calculate_is_liquidatable(collateral_value: Int, borrowed: Int) -> Bool {
  calculate_health_factor(collateral_value, borrowed) < 8500
}

pub fn calculate_partial_liquidation_amount(collateral: Int, borrowed: Int) -> Int {
  // Goal: health factor to reach 11000
  // health = collateral * 10000 / borrowed
  // If we repay some 'repaid' amount, we get: 
  // 11000 = collateral * 10000 / (borrowed - repaid)
  // borrowed - repaid = collateral * 10000 / 11000
  // repaid = borrowed - (collateral * 10000 / 11000)
  borrowed - (collateral * 10000 / 11000)
}

pub fn calculate_liquidator_bonus(collateral_amount: Int) -> Int {
  collateral_amount * 500 / 10000
}
