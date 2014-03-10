function plot_state
  ps = [1:200:10000];
  subplot(3, 2, 1);

  bi_plot_paths('results/kalman_bridge.nc', 'x', [], ps);
  grid on;
  title('Kalman filter');
  xlabel('t');
  ylabel('x');
  
  subplot(3, 2, 2);
  bi_plot_quantiles('results/kalman_bridge.nc', 'x');
  grid on;
  title('Kalman filter');
  xlabel('t');
  ylabel('x');
  
  subplot(3, 2, 3);
  bi_plot_paths('results/bootstrap_bridge.nc', 'x', [], ps);
  grid on;
  title('Bootstrap particle filter');
  xlabel('t');
  ylabel('x');

  subplot(3, 2, 4);
  bi_plot_quantiles('results/bootstrap_bridge.nc', 'x', [], ps);
  grid on;
  title('Bootstrap particle filter');
  xlabel('t');
  ylabel('x');
  
  subplot(3, 2, 5);
  bi_plot_paths('results/bridge_bridge.nc', 'x', [], ps);
  grid on;
  title('Bridging particle filter');
  xlabel('t');
  ylabel('x');

  subplot(3, 2, 6);
  bi_plot_quantiles('results/bridge_bridge.nc', 'x');
  grid on;
  title('Bridging particle filter');
  xlabel('t');
  ylabel('x');
end
