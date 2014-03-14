function prepare_obs
    % when simulating data sets, we simulate from the prior, not the joint,
    % as the observation block won't produce consistent results in this
    % case (it's a hack for the bridge case)... fix this now
    nc = netcdf('data/obs.nc', 'w');
    nc{'y'} = ncdouble('nr', 'np');
    nc{'y'}(:,:) = nc{'x'}(:,:);
    ncclose(nc);

    % create fixed observations
    nc = netcdf('data/obs_set.nc', 'c');
    nc('nr') = 1;
    nc{'time'} = ncdouble('nr');
    nc{'y'} = ncdouble('nr');
    nc{'time'}(:) = 1.0;
    nc{'y'}(:) = 0.15;
    ncclose(nc);
    
    % compute exact likelihoods for all data sets
    nc = netcdf('data/obs.nc', 'w');
    y = nc{'y'}(:,:);
    t = repmat(nc{'time'}(:), 1, columns(y));
    theta1 = 0.0187;
    theta2 = 0.2610;
    theta3 = 0.0224;
    
    h = diff(t);
    mu = theta1./theta2 .+ (y(1:end-1,:) .- theta1./theta2).*exp(-theta2.*h);
    sigma2 = theta3.^2.*(1.0 .- exp(-2.0.*theta2.*h))./(2.0.*theta2);
    ll = sum(log(normpdf(y(2:end,:), mu, sqrt(sigma2))));
    
    nc{'loglikelihood'} = ncdouble('np');
    nc{'loglikelihood'}(:) = ll;
    ncclose(nc);
end
