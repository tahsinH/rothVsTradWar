
function out = driver()
spouse1Earning = 100*1000; 
spouse2Earning = 100*1000;

% what is your 401k contribution rate
contributeRate = 12;

currentTrad = 200*1000; % current traditional 401k balance
currentRoth = 100*1000; % current roth 401k balance
numYears = 30;  % number of years to invest

% do you expect taxes to be same or slightly lower or do you expect them to be higher
shouldFutureRateBeSameOrLower = false;  

counter = 1; 
for i = contributeRate:-1:6 % assuming ppl put in atleast 6% to get company match
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
            predicted_trad_total(counter), ...
            predicted_roth_total(counter)] = ...
            preditIncomeAndBalance(trad(counter), currentTrad, roth(counter), currentRoth, numYears);
        
        currTaxable_income(counter) = spouse1Earning + spouse2Earning - trad(counter) - 24400; % 24400 is MFJ standard deduction
        counter = counter + 1; 
    end
end

[currMarginalTaxBracket, currTotalTax] = calculateTaxBracket(currTaxable_income, true);
[futureMarginalTaxBracket, futTotalTax] = calculateTaxBracket(predicted_taxable_income, shouldFutureRateBeSameOrLower);

tradPercent = tradPercentange';
rothPercent = rothPercentage';
futtaxable_income  = int32(predicted_taxable_income');
roth_income =  int32(predicted_roth_income');
trad_total  = int32(predicted_trad_total');
roth_total  = int32(predicted_roth_total');
totalPercent = tradPercent + rothPercent; 
futTotalTax = int32(futTotalTax');
currTotalTax = int32(currTotalTax');
total_income = futtaxable_income + roth_income - futTotalTax;
currTaxable_income = int32(currTaxable_income') - currTotalTax;
currTax = int8(currMarginalTaxBracket');
futTax = int8(futureMarginalTaxBracket');

out = table (totalPercent, ...
    tradPercent, ...
    rothPercent, ...
    currTaxable_income, ...
    futtaxable_income, ...
    currTax, ...
    futTax, ...  
    roth_income, ...
    total_income, ...
    trad_total, ...
    roth_total);