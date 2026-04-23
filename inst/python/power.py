import numpy as np
from scipy.stats import norm


def one_sample_power(delta, sigma, n, alpha=0.05, alternative="two-sided"):
    """
    Compute power for a one-sample mean test using a normal approximation.

    Parameters
    ----------
    delta : float
        True mean difference (mu - mu0).
    sigma : float
        Known or assumed population standard deviation.
    n : int
        Sample size.
    alpha : float, optional
        Significance level (default = 0.05).
    alternative : {"two-sided", "greater", "less"}
        Form of the alternative hypothesis.

    Returns
    -------
    float
        Power of the test.
    """

    # Noncentrality parameter
    Delta = delta * np.sqrt(n) / sigma

    if alternative == "two-sided":
        zcrit = norm.ppf(1 - alpha / 2)
        power = (
            1 - norm.cdf(zcrit - Delta)
            + norm.cdf(-zcrit - Delta)
        )

    elif alternative == "greater":
        zcrit = norm.ppf(1 - alpha)
        power = 1 - norm.cdf(zcrit - Delta)

    elif alternative == "less":
        zcrit = norm.ppf(alpha)
        power = norm.cdf(zcrit - Delta)

    else:
        raise ValueError("alternative must be 'two-sided', 'greater', or 'less'")

    return power
