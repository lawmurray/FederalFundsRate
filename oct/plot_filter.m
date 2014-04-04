function plot_filter
  ax = [190 194 0 0.2];
  ts = [951:971];
  obs_ts = [190:194];
  filters = {'Bootstrap'; 'Bridge'};

  for i = 1:length(filters);
      file = sprintf('results/filter_%s.nc', tolower(filters{i}));
      subplot(1, length(filters), i);
      bi_plot_paths(file, 'x', [], [], ts, i);
      hold on;
      
      % resampling lines
      t = ncread(file, 'time')(ts);
      A = ncread(file, 'ancestor')(:,ts);
      for j = 2:columns(A)
          if sum(A(:,j) != [0:(rows(A)-1)]') > 0
              % resampling occurred at this point
              line([t(j-1) t(j-1)], [ax(3) ax(4)], 'color', [0.7 0.7 0.7], ...
                   'linewidth', 10);
          end
      end

      % observations
      bi_plot_paths('data/obs.nc', 'y', [], [], obs_ts);
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
