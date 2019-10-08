
function out = driver()
spouse1Earning = 140*1000; 
spouse2Earning = 105*1000;

% what is your 401k contribution rate
maxContributeRate = 12;

currentTrad = 240*1000; % current traditional 401k balance
currentRoth = 80*1000; % current roth 401k balance
numYears = 30;  % number of years to invest

% do you expect taxes to be same or slightly lower or do you expect them to be higher
% current higher tax rate assumption is a custom version with some fudging
% of 2015 tax bracket
shouldFutureRateBeSame = false;  


counter = 1; 
for i = maxContributeRate:-1:6 % assuming ppl put in atleast 6% to get company match
    totalPercentage = i;
    for j = 0:totalPercentage
        tradPercentange(counter) = j; 
        rothPercentage(counter) = i-j;
        
        [trad(counter), roth(counter)] = calcTradVsRothContribAndTaxGivenPercentage(spouse1Earning, ...
            spouse2Earning, ...
            totalPercentage, ...
            tradPercentange(counter));
        
        [predicted_taxable_income(counter), ...
            predicted_roth_income(counter), ...
            socialSecurityNonTaxable(counter), ...
            predicted_trad_total(counter), ...
            predicted_roth_total(counter)] = ...
            preditIncomeAndBalance(trad(counter), currentTrad, roth(counter), currentRoth, numYears);
        
        currTaxable_income(counter) = spouse1Earning + spouse2Earning - trad(counter) - 24400; % 24400 is MFJ standard deduction
        counter = counter + 1; 
    end
end

[currMarginalTaxBracket, currTotalTax] = calculateTaxBracket(currTaxable_income, true);
[futureMarginalTaxBracket, futTotalTax] = calculateTaxBracket(predicted_taxable_income, shouldFutureRateBeSame);

tradPercent = tradPercentange';
rothPercent = rothPercentage';
futtaxable_income  = int32(predicted_taxable_income');
socialSecurityNonTaxable = int32(socialSecurityNonTaxable');
roth_income =  int32(predicted_roth_income');
trad_total  = int32(predicted_trad_total');
roth_total  = int32(predicted_roth_total');
totalPercent = tradPercent + rothPercent; 
futTotalTax = int32(futTotalTax');
currTotalTax = int32(currTotalTax');
total_income_afterTax = futtaxable_income + roth_income - futTotalTax + socialSecurityNonTaxable;
currTaxable_income = int32(currTaxable_income') - currTotalTax;
currBracket = int8(currMarginalTaxBracket');
futBracket = int8(futureMarginalTaxBracket');

out = table (totalPercent, ...
    tradPercent, ...
    rothPercent, ...
    currTaxable_income, ...
    futtaxable_income, ...
    currBracket, ...
    futBracket, ...  
    roth_income, ...
    futTotalTax, ...
    total_income_afterTax, ...
    trad_total, ...
    roth_total);