% Use n-gons with dimension dim at each interaction
HULL_N = 2^5;

DURATION = 200;
TS = 0.1;
MEASUREMENT_TIME = 1;
PLOT_TIME = 5;

global P_TRAIL

t = (0:TS:DURATION-TS);

figure(11)
plot(t(2:end),p_error(2:end))
xlabel('Time (s)')
ylabel('Position error (m)')
grid on

figure(12)
plot(t(2:end), volume(2:end))
xlabel('Time (s)')
ylabel('SVO area (m)')
grid on

figure(13)
i = 161;
P_TRAIL = p_history(:,1:i);
plot_all(real_history(i),...
    svo_history(i),...
    measurement_history(i),...
    intersection_history(i),...
    propagation_history(i));
xlabel('x (m)')
ylabel('y (m)')
title(['Position   -   t = ' + string(t(i)) + ' s'])

figure(14)
i = 2000;
P_TRAIL = p_history(:,1:i);
plot_all(real_history(i),...
    svo_history(i),...
    measurement_history(i),...
    intersection_history(i),...
    propagation_history(i));
xlabel('x (m)')
ylabel('y (m)')
title(['Position   -   t = ' + string(t(i)) + ' s'])

figure(15)
clf
sizes = [ ];
for i = 1:length(t)
    sizes = [sizes; [size(measurement_history(i).p.V,1) size(svo_history(i).p.V,1) size(intersection_history(i).p.V,1) size(propagation_history(i).p.V,1)]];
end
% plot(t, sizes,'.')
plot(t, sizes(:,1),'.','markersize',10)
hold on
plot(t, sizes(:,2),'.','markersize',8)
plot(t, sizes(:,3),'.','markersize',6)
plot(t, sizes(:,4),'.','markersize',4)
legend('measurement', 'svo', 'intersection', 'propagation')
xlabel('Time (s)')
ylabel('SVO # Vertices')
grid on


figure(16)
clf
sizes = [ ];
for i = 1:length(t)
    sizes = [sizes; [size(measurement_history(i).p.b,1) size(svo_history(i).p.b,1) size(intersection_history(i).p.b,1) size(propagation_history(i).p.b,1)]];
end
% plot(t, sizes,'.')
plot(t, sizes(:,1),'.','markersize',10)
hold on
plot(t, sizes(:,2),'.','markersize',8)
plot(t, sizes(:,3),'.','markersize',6)
plot(t, sizes(:,4),'.','markersize',4)
legend('measurement', 'svo', 'intersection', 'propagation')
legend('measurement', 'svo', 'intersection', 'propagation')
xlabel('Time (s)')
ylabel('SVO # half-planes')
grid on


function plot_all(real,svo,measurement,intersection,propagation)
global P_TRAIL
    r_in = measurement.radius(1);
    r_out = measurement.radius(2);

    s = linspace(0,2*pi,100)';
    c_in = r_in*[sin(s), cos(s)];
    c_out = r_out*[sin(s), cos(s)];

    plot(svo.p, 'color', 'yellow')
    hold on 
    plot(measurement.p, 'color', 'green')
    plot(propagation.p, 'color', 'blue')
    plot(intersection.p, 'color', 'red')

    plot(c_in(:,1), c_in(:,2))
    plot(c_out(:,1), c_out(:,2))
    
    scatter(0, 0,30,'*g')
    scatter(real.p(1), real.p(2),30,'*c')

    plot(P_TRAIL(1,:),P_TRAIL(2,:))

    axis equal
    xlim([-120,120])
    ylim([-120,120])
end