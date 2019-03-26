/*Contents of the SAS Dataset in library lproject.co2_n*/
proc contents data=lproject.co2_n; 
run;

/*Printing the first 10 observations of the SAS Dataset in library lproject.co2_n*/
proc print data=lproject.co2_n(obs=10); run;

/*Creating type_new column Sorted SAS datasets */
proc sort data=lproject.co2_n out=lproject.co2_n_t;
	by type_new;
run;

/*Creating treatment_new column Sorted SAS datasets */
proc sort data=lproject.co2_n out=lproject.co2_n_tr;
	by Treatment_new;
run;

/*Creating conc_new column Sorted SAS datasets */
proc sort data=lproject.co2_n out=lproject.co2_n_conc;
	by conc_new;
run;

/*Normal Histogram Plot of Uptake as well as normal test*/
ods graphics on;
proc univariate data=lproject.co2_n normaltest;
    histogram uptake /normal kernel;
run;
ods graphics off;

/*Histogram plot of uptake by treatment_new as well as normal test*/
ods graphics on;
proc univariate data=lproject.co2_n normaltest;
    histogram uptake /normal kernel;
    class treatment_new;
run;
ods graphics off;

/*Histogram plot of uptake by type_new as well as normal test*/
ods graphics on;
proc univariate data=lproject.co2_n normaltest;
    histogram uptake /normal kernel;
    class type_new;
run;
ods graphics off;

/*Histogram plot of uptake by conc_new in one panel*/
ods graphics on;
proc sgpanel data=lproject.co2_n;
    panelby conc_new;
    histogram uptake;
run;
ods graphics off;

/*Histogram plot of uptake by type_new in one panel*/
ods graphics on;
proc sgpanel data=lproject.co2_n;
    panelby type_new;
    histogram uptake;
run;
ods graphics off;

/*Histogram plot of uptake by treatment_new in one panel*/
ods graphics on;
proc sgpanel data=lproject.co2_n;
    panelby treatment_new;
    histogram uptake;
run;
ods graphics off;

/*Normality test of uptake var by type_new var with probplot*/
ods graphics on;
ods select Moments TestsForNormality ProbPlot;
proc univariate data=lproject.co2_n_t normaltest; 
   var uptake;
   by type_new;
   probplot uptake / normal (mu=est sigma=est)
                        square;
   label type_new = "type_new" uptake="Uptake";
   inset  mean std / format=6.4;
run;

/*Normality test of uptake var by treatment_new var with probplot*/
ods graphics on;
ods select Moments TestsForNormality ProbPlot;
proc univariate data=lproject.co2_n_tr normaltest; 
   var uptake;
   by treatment_new;
   probplot uptake / normal (mu=est sigma=est)
                        square;
   label treatment_new = "treatment_new" uptake="Uptake";
   inset  mean std / format=6.4;
run;

/*All relevant Frequency tables*/
proc freq data=lproject.co2_n;
tables (treatment_new type_new)*(conc_new type_new);
run;

/* Examining the Hypotheses: type ~ uptake graphically*/

ods graphics on;
proc sgplot data=lproject.co2_n ;
vbox uptake/group=type_new;
run;
ods graphics off;

/* Examining the Hypotheses: treatment ~ uptake graphically*/

ods graphics on;
proc sgplot data=lproject.co2_n_tr ;
vbox uptake/group=treatment_new;
run;
ods graphics off;

/* Examining the Hypotheses: concentration ~ uptake graphically*/

ods graphics on;
proc sgplot data=lproject.co2_n ;
vbox uptake/group=conc_new;
run;
ods graphics off;

/* Examining the Hypotheses: type*concentration ~ uptake graphically*/

ods graphics on;

proc sgplot data=lproject.co2_n;
    vbox uptake / category=type_new
                  group=treatment_new
                  groupdisplay=clustered;
    title "type & conc: main effect";
run;

ods graphics off;

/* Testing the Hypotheses: type ~ uptake using t-test*/

ods graphics on;

proc ttest data=lproject.co2_n_t plots(only)=(histogram boxplot) alpha=0.05;
    var uptake;
    class type_new;
run;

ods graphics off;

/* Testing the Hypotheses: treatment ~ uptake using t-test*/

ods graphics on;

proc ttest data=lproject.co2_n_tr plots(only)=(histogram boxplot) alpha=0.05;
    var uptake;
    class treatment_new;
run;

ods graphics off;

/* simple ANOVA test: concentration ~ uptake*/
ods graphics on;

proc anova data=lproject.co2_n; 
    class conc_new;
    model uptake = conc_new;
    label conc_new = "Concentration";
run;

ods graphics off;

/* From the above anova test we want to find if the differrence in meansof uptake of which concentrations
matters most*/

/* 1 and 2 conc levels*/

ods graphics on;

proc ttest data=lproject.co2_n_conc(obs=24) plots(only)=(histogram boxplot) alpha=0.05;
    var uptake;
    class conc_new;
run;

ods graphics off;

/* 2 and 3 conc levels*/

ods graphics on;

proc ttest data=lproject.co2_n_conc(firstobs=13 obs=36) plots(only)=(histogram boxplot) alpha=0.05;
    var uptake;
    class conc_new;
run;

ods graphics off;

/* 3 and 4 conc levels*/

ods graphics on;

proc ttest data=lproject.co2_n_conc(firstobs=25 obs=48) plots(only)=(histogram boxplot) alpha=0.05;
    var uptake;
    class conc_new;
run;

ods graphics off;

/* 4 and 5 conc levels*/

ods graphics on;

proc ttest data=lproject.co2_n_conc(firstobs=37 obs=60) plots(only)=(histogram boxplot) alpha=0.05;
    var uptake;
    class conc_new;
run;

ods graphics off;

/* 5 and 6 conc levels*/

ods graphics on;

proc ttest data=lproject.co2_n_conc(firstobs=49 obs=72) plots(only)=(histogram boxplot) alpha=0.05;
    var uptake;
    class conc_new;
run;

ods graphics off;

/* 6 and 7 conc levels*/

ods graphics on;

proc ttest data=lproject.co2_n_conc(firstobs=61 obs=84) plots(only)=(histogram boxplot) alpha=0.05;
    var uptake;
    class conc_new;
run;

ods graphics off;

/* ANOVA to find is there any difference in means of 2-7 concentration levels*/

ods graphics on;

proc anova data=lproject.co2_n_conc(firstobs=13 obs=84); 
    class conc_new;
    model uptake = conc_new;
    label conc_new = "Concentration";
run;

ods graphics off;

/* ANOVA test two-factor model: type+treatment ~ uptake*/

proc anova data=lproject.co2_n;
    class type_new treatment_new;
    model uptake = type_new|treatment_new;
run;
