function  irr_ref(A)
    [r,c] = size(A);
    counter = 2;
    while A(1,1) == 0 && counter<=r
        A([1 counter],:) = A([counter 1],:);
        
        fprintf('swap r1 with r%d to avoid zero in first row \n',counter);
        fprintf('******************\n');
        counter = counter+1;
    end
%     ******************************************************************
    i = 1;j = 1; 
    pivot = zeros(1,r);
    fprintf('\nEchlon Form: \n');
    fprintf('********************* \n');
    while i<=r && j <=c
        
        while A(i,j) == 0
           temp = i+1;
           rowo = 1;
           if rowo == 1
           while A(i,j) == 0 && i<=r
               A([i temp],:) = A([temp i],:);
               fprintf('swap r%d with r%d \n',i,temp);
               fprintf('******************\n');
               temp = temp+1;
           end
           rowo = 0;
           else
               temp = j;
              while A(i,j) == 0 && j<=c
                  j = j+1;
              end
           end
           disp(A);
        end
        pivot(i) = j;
        for row = i+1:r 
           num = A(row,j)/A(i,j);
           if num == 0
               continue;
           end
           A(row,:) = A(row,:) - A(i,:).*(num);
           fprintf('multiplie r%d by %d then subtract from r%d -> r%d \n',i,num,row,row);
           fprintf('******************\n');
           disp(A);
        end
        i = i+1;
        j = j+1;
    end
%     *******************************************************************
    fprintf('############################################################## \n');
    fprintf('reduced echlon form : \n');
    fprintf('************************ \n');
    for l = 1:r
        pos = pivot(l);
        if pos ~= 0 && A(l,pos) ~= 1
            fprintf('divide r%d by %d -> r%d \n',l,A(l,pos),l);
            fprintf('************************ \n');
            A(l,:) = A(l,:)./A(l,pos);
            disp(A);
        end
        
        if l>1
           for k = 1:l-1
               if A(k,pos) == 0
                   continue;
               end
               fprintf('multiplie r%d by %d then subtract from r%d -> r%d \n',l,A(k,pos),k,k);
               fprintf('************************************ \n');
               A(k,:) = A(k,:) - A(l,:).*(A(k,pos));
               disp(A);
           end
        end
    end
% **********************************************************************
    fprintf('##############################################################\n');
    fprintf('Final answer is : \n');
    fprintf('******************\n');
    disp(A);
end