% Use n-gons with dimension dim at each interaction
HULL_N = 2^5;

DURATION = 200;
TS = 0.1;
MEASUREMENT_TIME = 1;
PLOT_TIME = 0.1;

t = (0:TS:DURATION-TS);

% frames = struct('cdata',cell(1,length(t)),'colormap',cell(1,length(t)));

for i = 1:length(t)
    svo = svo_history(i);
    measurement = measurement_history(i);
    intersection = intersection_history(i);
    propagation = propagation_history(i);
    real = real_history(i);

    P_TRAIL = p_history(:,1:i);
    if(mod(i-1,round(PLOT_TIME/TS))==0)
        plot_all(real,svo,measurement,intersection,propagation,P_TRAIL,t(i));
%         frames(i) = getframe(gcf);
    end
    pause(0);
end

% writerObj = VideoWriter('position.avi');
% writerObj.FrameRate = 30;
% open(writerObj);
% writeVideo(writerObj, frames);
% close (writerObj);

function plot_all(real,svo,measurement,intersection,propagation,P_TRAIL,t)
    clf
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

    xlabel('x (m)')
    ylabel('y (m)')

    title(['t = ' + string(t) + ' s'])
end