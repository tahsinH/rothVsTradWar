function [predicted_taxable_income, predicted_roth_income, socialSecurityNonTaxable, predicted_trad_total, predicted_roth_total] =  ...
    preditIncomeAndBalance(moreTradContributionPerYear, currentTrad, moreRothContributionPerYear, currentRoth, numYears)

growthRate = 0.06; % real growth rate, (inflation adjusted)

predicted_trad_total = fvfix(growthRate, numYears , moreTradContributionPerYear,currentTrad);
predicted_trad_income = predicted_trad_total * 0.04; % 4 percent safe withdrwal rate
socialSecurityEarnings = 2083 * 12 * 2 ;% 2.8k/month for 12 months a year for 2 people (spouse)
socialSecurityTaxableIncome = socialSecurityEarnings * 0.85; % assuming 85% being taxable for high earners; 
predicted_taxable_income = predicted_trad_income + socialSecurityTaxableIncome;

socialSecurityNonTaxable = socialSecurityEarnings* 0.15; 

predicted_roth_total = fvfix(growthRate, numYears , moreRothContributionPerYear,currentRoth);
predicted_roth_income = predicted_roth_total * 0.04; % 4 percent safe withdrwal rate

end
