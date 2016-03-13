function showhist(intervals, histw)

figure
bar(intervals + (intervals(2) - intervals(1)) / 2, (histw / sum(histw)) * 100);
ylabel('Percentage (%)', 'fontsize', 18);
xlabel('Angle (degrees)', 'fontsize', 18);

end