function [predicted_taxable_income, predicted_roth_income, predicted_trad_total, predicted_roth_total] =  ...
    preditIncomeAndBalance(moreTradContributionPerYear, currentTrad, moreRothContributionPerYear, currentRoth, numYears)

growthRate = 0.06; % real growth rate, (inflation adjusted)

predicted_trad_total = fvfix(growthRate, numYears , moreTradContributionPerYear,currentTrad);
predicted_trad_income = predicted_trad_total * 0.04; % 4 percent safe withdrwal rate
socialSecurityIncome = 2083 * 12 * 2 * 0.85; % 2.8k/month for 12 months a year for 2 people (spouse) with 85% being taxable; 
predicted_taxable_income = predicted_trad_income + socialSecurityIncome;

predicted_roth_total = fvfix(growthRate, numYears , moreRothContributionPerYear,currentRoth);
predicted_roth_income = predicted_roth_total * 0.04; % 4 percent safe withdrwal rate

end
