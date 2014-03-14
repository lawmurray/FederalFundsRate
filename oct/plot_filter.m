function plot_filter
  ax = [0 1 -0.05 0.2];
  ps = [];
  filters = {'Bootstrap'; 'Bridge'};

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
              patch([t(to) t(to + 1) t(to + 1) t(to)], [ax(3) ax(3) ax(4) ...
                                  ax(4)], 'facecolor', [0.9 0.9 0.9], ...
                    'facealpha', 0.5);
              hold on;
              bi_plot_paths(file, 'x', [], ps, [from:to], i);
              from = j;
          end
          to = j;
      end
      bi_plot_paths(file, 'x', [], ps, [from:to], i);
      hold on;
      ncclose(nc);
      
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
