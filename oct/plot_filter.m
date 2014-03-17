function plot_filter
  ax = [0 1 -0.05 0.2];
  ps = [];
  filters = {'Bootstrap'; 'Bridge'};

  r = {};
  for i = 1:length(filters);
      file = sprintf('results/filter_%s.nc', tolower(filters{i}));
      subplot(1, length(filters), i);
      
      nc = netcdf(file, 'r');
      t = nc{'time'}(:);
      A = nc{'ancestor'}(:,:)';
      from = 1;
      to = 0;
      for j = 1:columns(A)
          if sum(A(:,j) != [0:(rows(A)-1)]') > 0
              % resampling occurred at this point
              r{length(r) + 1} = [t(to) t(to + 1)];
              bi_plot_paths(file, 'x', [], ps, [from:to], i);
              hold on;
              from = j;
          end
          to = j;
      end
      bi_plot_paths(file, 'x', [], ps, [from:to], i);
      hold on;
      ncclose(nc);
 
      % resampling lines
      for j = 1:length(r)
          patch([r{j}(1) r{j}(2) r{j}(2) r{j}(1)], [ax(3) ax(3) ax(4) ax(4)], 'edgecolor', 'k', 'linewidth', 4, 'facecolor', 'k');
          hold on;
      end
      
      bi_plot_paths('data/obs_set.nc', 'y');
      hold off;
      axis(ax);
      title(filters{i});
      xlabel('t');
      if i == 1
          ylabel('x');
      end
      grid on;
    end
end
