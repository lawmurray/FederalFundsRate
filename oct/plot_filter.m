function plot_filter
  ps = [1:8:512];
  ax = [0 1 -0.05 0.2];

  subplot(1, 3, 1);
  bi_plot_quantiles('results/filter_kalman.nc', 'x', [], [], [], 3);
  grid on;
  title('Kalman filter');
  xlabel('t');
  ylabel('x');
  axis(ax);

  subplot(1, 3, 2);
  bi_plot_paths('results/filter_bootstrap.nc', 'x', [], ps, [], 1);
  grid on;
  title('Bootstrap particle filter');
  xlabel('t');
  axis(ax);
  
  subplot(1, 3, 3);
  bi_plot_paths('results/filter_bridge.nc', 'x', [], ps, [], 2);
  grid on;
  title('Bridge particle filter');
  xlabel('t');
  axis(ax);
end
