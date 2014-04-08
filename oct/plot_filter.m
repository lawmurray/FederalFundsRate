function plot_filter
  ax = [0 4 0.08 0.12];
  ts = [1:41];
  obs_ts = [1:4];
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
