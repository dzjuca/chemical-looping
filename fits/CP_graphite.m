clc
clear 
close all

R = 8.31446261815324;

T = [298.15; 300.00; 400.00; 500.00; 600.00; 700.00; 800.00; 900.00; 1000.0;
     1100.0; 1200.0; 1300.0; 1400.0; 1500.0; 1600.0; 1700.0; 1800.0; 1900.0; 
     2000.0; 2100.0; 2200.0; 2300.0; 2400.0; 2500.0; 2600.0; 2700.0; 2800.0;
     2900.0; 3000.0; 3100.0; 3200.0; 3300.0; 3400.0; 3500.0; 3600.0; 3700.0;
     3800.0; 3900.0; 4000.0; 4100.0];
Cp = [8.512; 8.5940; 11.927; 14.633; 16.884; 18.590; 19.827; 20.792; 21.566;
     22.192; 22.702; 23.117; 23.453; 23.725; 23.946; 24.127; 24.278; 24.410;
     24.533; 24.648; 24.745; 24.835; 24.919; 24.997; 25.071; 25.142; 25.211;
     25.278; 25.344; 25.409; 25.473; 25.537; 25.601; 25.665; 25.730; 25.795;
     25.861; 25.928; 25.996; 26.066];

Cp_N = Cp./R;


%CREATEFIT(T,CP)
%  Create a fit.
%
%  Data for 'untitled fit 2' fit:
%      X Input: T
%      Y Output: Cp
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 23-Nov-2022 10:16:30


%% Fit: 'untitled fit 2'.
% [xData, yData] = prepareCurveData( T, Cp );
% 
% % Set up fittype and options.
% ft = fittype( 'power2' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Display = 'Off';
% opts.StartPoint = [8.17048523047082 0.386575587868082 -2.72129841847769];
% 
% % Fit model to data.
% [fitresult, gof] = fit( xData, yData, ft, opts );


% ---------
 [xData, yData] = prepareCurveData( T, Cp_N );

% Set up fittype and options.
ft = fittype( 'poly6' );
opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Normalize = 'on';
opts.Robust = 'Bisquare';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'Cp_N vs. T', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'T', 'Interpreter', 'none' );
ylabel( 'Cp_N', 'Interpreter', 'none' );
grid on