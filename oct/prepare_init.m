function prepare_init()
    init_file = 'data/init.nc';
    init_test_filter_file = 'data/init_test_filter.nc';
    obs_file = 'data/obs.nc';
    
    % create init file
    try
      nccreate(init_file, 'theta1');
      nccreate(init_file, 'theta2');
      nccreate(init_file, 'theta3');
    catch
        % assume variables already exist...
    end
    
    ncwrite(init_file, 'theta1', 0.011969);
    ncwrite(init_file, 'theta2', 0.26028);
    ncwrite(init_file, 'theta2', 0.016356);
    
    % compute exact likelihoods for all parameters sampled for test_filter
    theta1 = ncread(init_test_filter_file, 'theta1');
    theta2 = ncread(init_test_filter_file, 'theta2');
    theta3 = ncread(init_test_filter_file, 'theta3');
    
    t = ncread(obs_file, 'time');
    y = ncread(obs_file, 'y');
    x = [ 0.008; y(1:end-1) ];
    h = diff([ 0; t ]);
    
    ll = zeros(length(theta1));
    for k = 1:length(ll)
        mu = theta1(k)/theta2(k) + (x - theta1(k)/theta2(k)).*exp(-theta2(k)*h);
        sigma2 = theta3(k)^2*(1.0 - exp(-2.0*theta2(k)*h))/(2.0.*theta2(k));
        ll(k) = sum(log(normpdf(y, mu, sqrt(sigma2))));
    end
    
    try
      nccreate(init_test_filter_file, 'loglikelihood', 'Dimensions', ...
               {'np'});
    catch
        % assume variable already exists...
    end
    ncwrite(init_test_filter_file, 'loglikelihood', ll);
end
