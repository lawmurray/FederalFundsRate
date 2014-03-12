function plot_filter
  ax = [0 1 -0.05 0.2];
  ps = [];
  filters = {'Kalman'; 'Bootstrap'; 'Bridge'};

  for i = 1:length(filters);
      file = sprintf('results/filter_%s.nc', tolower(filters{i}));
      subplot(1, length(filters), i);
      if strcmp(filters{i}, 'Kalman')
          bi_plot_quantiles(file, 'x', [], [], [], 3);
      else
          bi_plot_paths(file, 'x', [], ps, [], i - 1);
      end
      hold on;
      
      if !strcmp(filters{i}, 'Kalman')
          nc = netcdf(file, 'r');
          t = nc{'time'}(:);
          A = nc{'ancestor'}(:,:)';
          for j = 1:columns(A)
              if sum(A(:,j) != [0:(rows(A)-1)]') > 0
                  % resampling occurred at this point
                  line([t(j) t(j)], [ax(3) ax(4)], 'color', 'k');
                  %t
              end
          end
          ncclose(nc);
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
