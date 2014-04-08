/**
 * Ornstein---Uhlenbeck model for U.S. Federal Funds Rate.
 *
 * The model is set up for bridge sampling, where the observation block
 * provides the weighting p(x(n)|x(n-1)). The state variable mu holds the mean
 * of x(n) at each time, without the noise term w(n) having yet been
 * added. This is then used in the observation block to weight appropriately.
 */
model OrnsteinUhlenbeckBridge {
  const h = 0.1;

  param theta1, theta2, theta3;
  noise w;
  state mu, x;
  obs y;

  inline sigma = sqrt(theta3**2.0*(1.0 - exp(-2.0*theta2*h))/(2.0*theta2));

  sub parameter {
    theta1 ~ uniform(0.0, 1.0);
    theta2 ~ uniform(0.0, 1.0);
    theta3 ~ uniform(0.0, 1.0);
  }

  sub proposal_parameter {
    theta1 ~ truncated_gaussian(theta1, 4.0e-5, 0.0, 1.0);
    theta2 ~ truncated_gaussian(theta2, 1.0e-3, 0.0, 1.0);
    theta3 ~ truncated_gaussian(theta3, 4.0e-5, 0.0, 1.0);
  }

  sub initial {
    mu <- 0.0912; // first obs for FFR data, Jan 1989, not in obs file
    x <- 0.0912;
  }

  sub transition(delta = h) {
    mu <- theta1/theta2 + (x - theta1/theta2)*exp(-theta2*h);
    w ~ gaussian(0.0, sigma);
    x <- (t_now < t_next_obs && t_next_obs <= t_now + 1.01*h) ? y : mu + w;
  }

  sub bridge {
    inline bdelta = t_next_obs - t_now;
    inline bmu = theta1/theta2 + (x - theta1/theta2)*exp(-theta2*bdelta);
    inline bsigma = sqrt(theta3**2.0*(1.0 - exp(-2.0*theta2*bdelta))/(2.0*theta2));

    y ~ gaussian(bmu, bsigma);
  }

  sub observation {
    y ~ gaussian(mu, sigma);
  }
}
