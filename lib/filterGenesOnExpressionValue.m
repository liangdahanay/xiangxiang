function newgdata = filterGenesOnExpressionValue(gdata,expIndices, expThreshValue, above,filename);
%
nExpr = numel(gdata{1}.exp);

newgdata = {};
count = 1;
for i=1:numel(gdata)
    ok = 0;
    gd = gdata{i};
    for(j=1:nExpr)       
        expr = gd.exp(j);
        %txt = sprintf('considering expression: %f',expr);
        %disp(txt);
        
        if(isnan(expr))
            continue;
        end
		if(not(expIndices(1)==-1))
            found = 0;
            for(k=1:numel(expIndices))
                if(j==expIndices(k))
                    found = 1;
                    break;
                end
            end
            if(found==0)
                continue;
            end
        end
       
        if(above==1)
            if(expr>=expThreshValue)
                ok = 1;
                break;
            end            
        else
            if(expr<=expThreshValue)
                ok = 1;
                break;
            end
        end
    end
    %if(ok==0)
        %disp('excluding gene:');
        %disp(gd);
        %pause
    %end
    if(ok==1)
        newgdata{count} = gdata{i};
        count = count +1;
        %disp('including gene:');
        %disp(gdata{i});
        %pause
    end
end


txt = sprintf('%d genes remaining after filtering',count-1);
disp(txt);
saveGenesToGdfFile(newgdata,filename);

    


