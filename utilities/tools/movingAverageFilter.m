%% Moving average filter

function y = movingAverageFilter(x,windowSize)

% A moving-average filter slides a window of length windowSize along the data, computing averages
% of the data contained in each window.

% The moving average filter is simple and effective. One of the things that is a problem is the lag associated
% with the moving average filter. The more samples used the longer the lag experienced(All filters have lag).
% How much lag can be tolerated is up to the individual.

% windowSize = 3;
% y(1:windowSize-1) = x_filtered(1:windowSize-1);
y = x;
for i=windowSize:length(x)
    y(i) = (1/windowSize)*sum(x(i-(windowSize-1):i));
end

end