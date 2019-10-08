
function [trad, roth, taxableIncomeNow] = ...
    calcTradVsRothContribAndTaxGivenPercentage (spouse1Earnings, spouse2Earnings, totalPercentangeToContribute, tradPercentageToContribute)
currentEarningsPerYear = spouse1Earnings  + spouse2Earnings ; 

% the employer contribution always goes in as traditional contribution,
% assuming 6% with 100% match
employer  = currentEarningsPerYear * 0.06;
tradEmployee = currentEarningsPerYear * tradPercentageToContribute/100;

trad = employer + tradEmployee;
roth = currentEarningsPerYear * (totalPercentangeToContribute - tradPercentageToContribute)/100;

if (tradEmployee + roth) > 19500*2 % 401k maxium(well sort of, not accounting for after-tax 401k here)
    error("Exceeding maximum allowed total% %d with trad% %d", totalPercentangeToContribute, tradPercentageToContribute);
end


% standard deduction for married filing jointly
standardDeduction = 24400; 

taxableIncomeNow = currentEarningsPerYear - standardDeduction - trad; 