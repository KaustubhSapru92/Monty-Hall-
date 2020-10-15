clear all
Door = [1,0,0];
 
strategy = 1; %switching choice


W = 0; %Initialized win tally
L = 0; 

for i = 1:10000
    bar = Door(randperm(numel(Door))); % the door which will eventually have the gold
    guess = randi(1,3); %Initial door choice
    Win = find(bar); % Door with the gold bar 
    HostOption = find(bar==0); %Door without the gold bar
        
    switch Win
        case 1  % ponty shows you baby calf behind doors 2 or 3 
            guess = Win;
            HostRevealRand = datasample(HostOption,1); % Randomly open one of the loosing doors
            %Zero out whichever door the host revealed
            HostCheck = HostOption - HostRevealRand;
        
            %Find the door the host did not reveal i.e. whichever one wasn't zeroed out
            HostCheckIndex = find(HostCheck);
            HostLeftOver = HostOption(HostCheckIndex);
        
            %Determine doors now available to player: original winning choice and a losing door
            PlayerOption = [guess HostLeftOver];
        
            if strategy == 0
                choice2 = PlayerOption(1);
            elseif strategy == 1
                choice2 = PlayerOption(2);
            end
        case 2 % ponty shows you baby calf behind doors 1 or 3
            guess = HostOption(1);
            PlayerOption = [guess Win];
                 
            if strategy == 0
                choice2 = PlayerOption(1);
            elseif strategy == 1
                choice2 = PlayerOption(2);
            end
        case 3 % ponty shows you baby calf behind doors 1 or 2 
            guess = HostOption(2);
            PlayerOption = [guess Win];
             
            if strategy == 0
                choice2 = PlayerOption(1);
            elseif strategy == 1
                choice2 = PlayerOption(2);
            end
    end
    
    if choice2 == Win
        W = W + 1;
    else
        L = L + 1;
    end
    
    
end

fprintf('Probabiliy of winning when contestant switched is %0.2f %%\n',W/100);
fprintf('Probabiliy of losing when contestant switched is %0.2f %%\n',L/100);
