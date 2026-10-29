# A/A/B Testing & Sales Funnel Analysis

## Project Overview

This project analyzes user behavior in a food-products company's mobile
app. It combines exploratory data analysis (EDA), sales-funnel analysis,
and an A/A/B experiment to evaluate whether changing the app's fonts had
a measurable effect on user behavior.

The analysis uses event logs to understand how users move through the
purchase journey, identify where users drop off, and compare conversion
behavior across three experiment groups.

## Business Questions

-   Which events occur most frequently in the app?
-   How many users reach each stage of the purchase funnel?
-   At which stage is the largest user drop-off?
-   Are the two control groups statistically similar?
-   Does the new font design (test group) produce a statistically
    significant change in user behavior?

## Dataset

Each row represents a user action or event. The dataset includes the
following fields:

  Column             Description
  ------------------ ----------------------------------------
  `EventName`        Name of the event performed in the app
  `DeviceIDHash`     Unique user identifier
  `EventTimestamp`   Date and time of the event
  `ExpId`            Experiment group assigned to the user

The experiment groups are: - **246:** Control group A1 --- existing
fonts - **247:** Control group A2 --- existing fonts - **248:** Test
group B --- new fonts

The dataset covers **July 25 to August 7, 2019**. Event activity becomes
more complete and consistent from **August 1, 2019**, so the analysis
focuses on **August 1--7, 2019**. During data validation, 413 duplicate
records were identified and removed.

## Tools & Libraries

-   **Python**
-   **Pandas** --- data cleaning, manipulation, and aggregation
-   **NumPy** --- numerical operations
-   **Matplotlib** and **Seaborn** --- data visualization
-   **SciPy** --- statistical analysis
-   **Statsmodels** --- two-proportion z-tests

## Project Workflow

1.  **Data loading and preparation**
    -   Load the event-log dataset.
    -   Standardize column names.
    -   Check for and remove duplicate records.
2.  **Data exploration and validation**
    -   Review event and user counts.
    -   Calculate the average number of events per user.
    -   Examine the time coverage and identify the period with more
        complete data.
    -   Filter the dataset to August 1--7, 2019.
3.  **Sales funnel analysis**
    -   Count events and unique users by event.
    -   Build the main purchase journey:
        `MainScreenAppear → OffersScreenAppear → CartScreenAppear → PaymentScreenSuccessful`
    -   Calculate user conversion between funnel stages.
    -   Identify the largest drop-off point.
4.  **A/A/B experiment analysis**
    -   Compare control groups 246 and 247 to check whether their
        behavior is statistically similar.
    -   Compare test group 248 with each control group and with the
        combined control groups.
    -   Use two-proportion z-tests to evaluate differences in event
        participation.
    -   Apply a Bonferroni correction to account for multiple
        statistical tests.

## Key Findings

### Sales Funnel

The main purchase journey was identified as:

`MainScreenAppear → OffersScreenAppear → CartScreenAppear → PaymentScreenSuccessful`

The largest drop-off occurs between the main screen and the offers
screen: **61.91%** of users who reach the main screen proceed to the
offers screen. Conversion is stronger in the later stages:

-   **Offers screen → Cart:** 81.30%
-   **Cart → Successful payment:** 94.78%

This indicates that the beginning of the user journey is the main point
to investigate for potential improvements.

### A/A/B Test

The comparison between control groups 246 and 247 found no statistically
significant differences for the events analyzed, suggesting that the two
control groups behaved similarly.

The analysis then compared the new-font test group (248) with each
control group and with both control groups combined. After applying the
Bonferroni correction across the 16 statistical tests, **none of the
differences were statistically significant**.

The experiment therefore provides insufficient statistical evidence that
changing the app's fonts affected user behavior or conversion.

## Conclusion

The funnel analysis highlights the transition from the main screen to
the offers screen as the largest drop-off point in the purchase journey.
This is a useful area for further investigation and product
optimization.

The A/A/B test did not find statistically significant evidence that the
new fonts improved or harmed user behavior. Based on this experiment,
there is not enough evidence to recommend changing the fonts as a way to
improve app performance.

## Skills Demonstrated

-   Exploratory data analysis (EDA)
-   Data cleaning and validation
-   Duplicate detection and handling
-   Event-log analysis
-   Conversion funnel analysis
-   Data visualization
-   Hypothesis testing
-   Two-proportion z-tests
-   Multiple-comparison correction (Bonferroni)
-   Translating analytical results into business recommendations

------------------------------------------------------------------------

*This project was completed as a data analytics portfolio project. The
findings and recommendations are based on the dataset and analysis
documented in the notebook.*
