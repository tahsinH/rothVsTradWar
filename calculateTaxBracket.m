function [allMarginalRate, allTaxpaid] = calculateTaxBracket(allIncome, currTaxRate)

if (currTaxRate)   
    % 2019 tax rate
    rates=[0.10,  0.12,  0.22,   0.24,   0.32,   0.35, 0.37];
    brackets=[0, 19400, 78950, 168400, 321450, 408200, 612350];
else
    % closer to what it was in 2015, expecting that 2015 tax rate in future
    rates=[0.10,  0.12,  0.25,   0.28,   0.33,   0.37,   0.40];
    brackets=[0, 19400, 78950, 168400, 250000, 321450, 450000];
end


for i = 1: numel(allIncome)
    income = allIncome(i);
    
    bracketRevenues =[0, cumsum( diff(brackets).*rates(1:end-1))];
    [~,n]= histc(income,[brackets,inf]);
    taxrate = rates(n);
    taxpaid = bracketRevenues(n) + (income-brackets(n))*taxrate;
    allMarginalRate(i) = taxrate*100;
    allTaxpaid(i) = taxpaid;
end
end

