function plot_filter_set
  ax = [0 1 -0.05 0.2];
  filters = {'Bootstrap'; 'Bridge'};

  for i = 1:length(filters);
      file = sprintf('results/filter_set_%s.nc', tolower(filters{i}));
      subplot(1, length(filters), i);
      bi_plot_paths(file, 'x', [], [], [], i);
      hold on;
      
      % resampling lines
      nc = netcdf(file, 'r');
      t = nc{'time'}(:);
      A = nc{'ancestor'}(:,:)';
      for j = 1:columns(A)
          if sum(A(:,j) != [0:(rows(A)-1)]') > 0
              % resampling occurred at this point
              line([t(j-1) t(j-1)], [ax(3) ax(4)], 'color',[0.7 0.7 0.7], ...
                   'linewidth', 10);
          end
      end

      % observations
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
