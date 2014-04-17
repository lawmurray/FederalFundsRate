% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_and_print ()
%
% Produce plots and print for manuscript.
% @end deftypefn
%
function plot_and_print ()
    FIG_DIR = 'figs';
    mkdir(FIG_DIR);

    sz = [ 12 4 ];
    set (figure(1), 'papersize', sz);
    set (figure(1), 'paperposition', [0 0 sz]);

    subplot(1,3,1);
    plot_metric(1);
    title('MSE(log z)^{-1} Mean(t)^{-1}');
    xlabel('Bootstrap');
    ylabel('Bridge');
    subplot(1,3,2);
    plot_metric(2);
    title('ESS(z) Mean(t)^{-1}');
    xlabel('Bootstrap');
    subplot(1,3,3);
    plot_metric(3);
    title('CAR(z) Mean(t)^{-1}');
    xlabel('Bootstrap');
    file = sprintf('%s/metrics.pdf', FIG_DIR);
    saveas(figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));

    clf;
    plot_filter;
    file = sprintf('%s/filter.pdf', FIG_DIR);
    saveas (figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));
    
    clf;
    ts = [1:121];
    obs_ts = [1:12];
    
    subplot(3,3,1:6);
    bi_plot_quantiles('results/posterior.nc', 'x', [], [], ts);
    hold on;
    bi_plot_paths('data/obs.nc', 'y', [], [], obs_ts);
    xlabel('t');
    ylabel('x');
    grid on;
    
    subplot(3,3,7);
    bi_hist('results/posterior.nc', 'theta1', [], [], [], 20, []);
    xlabel('\theta_1');
    grid on;
    
    subplot(3,3,8);
    bi_hist('results/posterior.nc', 'theta2', [], [], [], 20, []);
    xlabel('\theta_2');
    grid on;

    subplot(3,3,9);
    bi_hist('results/posterior.nc', 'theta3', [], [], [], 20, []);
    xlabel('\theta_3');
    grid on;

    sz = [ 12 4.5 ];
    set (figure(1), 'papersize', sz);
    set (figure(1), 'paperposition', [0 0 sz]); 
    file = sprintf('%s/posterior.pdf', FIG_DIR);
    saveas (figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));
end
