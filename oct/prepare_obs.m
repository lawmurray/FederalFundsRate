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
end
