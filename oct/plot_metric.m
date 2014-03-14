function plot_metric(metric)
    if nargin < 1
        metric = 1;
    end
    
    % true likelihoods for MSE calculation
    nc = netcdf('data/obs.nc', 'r');
    ll = nc{'loglikelihood'}(:);
    ncclose(nc);
    
    P = {};
    y = {};
    filters = {'Bootstrap'; 'Bridge'};
    for i = 1:length(filters)
        y{i} = [];
        P{i} = [];
        rep = 0;
        file = sprintf('results/test_%s-%d.nc', tolower(filters{i}), rep);
        while exist(file, 'file')
            nc = netcdf(file, 'r');
            L = nc{'loglikelihood'}(:,:)';
            T = nc{'time'}(:,:)';
        
            if metric == 1
                tmp = -mean((L - ll(i)).^2)'./mean(T)';
            elseif metric == 2
                tmp = ess(L)'./mean(T)';
            elseif metric == 3
                tmp = car(L)'./mean(T)';
            end
            y{i} = [ y{i}; tmp ];
            P{i} = [ P{i}; nc{'P'}(:) ];
            ncclose(nc);
            
            rep = rep + 1;
            file = sprintf('results/test_%s-%d.nc', tolower(filters{i}), rep);
        end
    end

    for i=1:rows(y{1})
        if y{1}(i) > y{2}(i)
            col = watercolour(1);
        else
            col = watercolour(2);
        end
        h = loglog(y{1}(i), y{2}(i), 'o', 'color', col, 'markersize', ...
                   sqrt(P{1}(i)/pi), 'linewidth', 3);
        hold on;
    end

    %axis('tight');
    ax = axis();
    mn = min([ax(1), ax(3)]);
    mx = max([ax(2), ax(4)]);
    loglog([mn mx], [mn mx], '--k');
    axis([mn mx mn mx]);
    axis('square');
    grid minor on;
end
