function final_project ()
% main loop
while true
    clc;
    cprintf('*blue',' 1) draw shape \n 2) import image \n 0) to exit \n');
    prompt = ' : ';
    select = input(prompt);
    switch select
        case 0
            clc;
            return;
        case 1
            draw_shape();
        case 2
            import_image();
        otherwise
            warning('please enter only one of the above');
    end
end
%     ************************************************************
end

function import_image ()
prompt = ('enter the name of image : ');
name_of_image = input(prompt);
image_matrix = imread(name_of_image);
figure;
image(image_matrix);
while true
    prompt = ('select the oepration : \n 1) rotate CCW \n 2) rotate CC\n 3) flip horizontal\n 4) flip vertical \n 5) rotate by angle\n 0) to exit \n :  ');
    operation = input(prompt);
    switch operation
        case 0
            close all;
            return;
        case 1
            image_matrix = imrotate(image_matrix,90);
            image(image_matrix);
        case 2
            image_matrix = imrotate(image_matrix,-90);
            image(image_matrix);
        case 3
            image_matrix = flipdim(image_matrix,2);
            image(image_matrix);
        case 4
            image_matrix = flipdim(image_matrix,1);
            image(image_matrix);
        case 5
            prompt = 'enter the angle : ';
            angle = input(prompt);
            image_matrix = imrotate(image_matrix,angle);
            image(image_matrix);
    end
end
end

function draw_shape ()
cprintf('-comment','Enter number of sides \n');
prompt = ' : ';
num_of_sides = input(prompt);
cprintf('-comment','enter the vertics as [{x1,y1},{x2,y2}]\n');
prompt = (' : ');
vertices = input(prompt);
if length(vertices) ~= 2*num_of_sides
    warning('please enter vertices equal to sides');
    return;
end
x=vertices(1:2:end);
y=vertices(2:2:end);
x=cell2mat(x);
y=cell2mat(y);
x(1,num_of_sides+1) = x(1,1);
y(1,num_of_sides+1) = y(1,1);
subplot(2,1,1);
title('original view');
fill(x,y,'r');
axis square;
subplot(2,1,2);
fill(x,y,'r');
axis square;
% flages : 
state=1;
operation =100;
%     ****************************************************
while true  
    if operation <= 10
    clc;
    end
    cprintf('-comment',' select the oepration : \n');
    cprintf('[1,0,1]',' 1) rotate CCW \n 2) rotate CC\n 3) flip horizontal\n 4) flip vertical \n 5) rotate by angle \n 6) shift\n 7) horizontal shear \n 8) vertical shear \n 9) scaling \n');
    if state
        cprintf('*green',' 10) Add projection transformation \n');
    else
        cprintf('*red',' 10) remove projection transofrmation \n');
    end
    cprintf('*blue',' 0) to exit \n')
    prompt=(' : ');
    operation = input(prompt);
    switch operation
        case 0
            close all;
            return;
        case 1
            [x, y] = rotate_90_ccw(x,y,state);
        case 2
            [x, y] = rotate_90_cc(x,y,state);
        case 3
            [x,y] = flip_h(x,y,state);
        case 4
            [x,y] = flip_v(x,y,state);
        case 5
            [x,y] = rotate(x,y,state);
        case 6
            [x,y] = shift(x,y,state);
        case 7
            [x,y] = shear_v(x,y,state);
        case 8
            [x,y] = shear_h(x,y,state);
        case 9
            [x,y] = scale(x,y,state);
        case 10
            [state] = projection(x,y,state);
        otherwise
            warning('please enter only one of the above');
            plot_shape(x,y,state);
    end
    
end
end

function [x_rot,y_rot] =  rotate_90_ccw (x,y,state)
x_rot = -1.*y;
y_rot = x;
plot_shape(x_rot,y_rot,state);
end

function [x_rot,y_rot] = rotate_90_cc (x,y,state)
x_rot = y;
y_rot = -1.*x;
plot_shape(x_rot,y_rot,state);
end

function [x_flip,y_flip] = flip_h(x,y,state)
x_flip = -1.*x;
y_flip = y;
plot_shape(x_flip,y_flip,state);
end

function [x_flip,y_flip] = flip_v(x,y,state)
x_flip = x;
y_flip = -1.*y;
plot_shape(x_flip,y_flip,state);
end

function [x_rot_g,y_rot_g] = rotate (x,y,state)
prompt = 'enter the angle : ';
angle = input(prompt);
x_rot_g = cosd(angle).*x + sind(angle).*y;
y_rot_g = -sind(angle).*x + cosd(angle).*y ;
plot_shape(x_rot_g,y_rot_g,state);
end

function [x_shifted,y_shifted] = shift(x,y,state)
    while true
    prompt = 'enter the shift value : ';
    shift = input(prompt);  
    if isscalar(shift)
        warning('enter shift in vector form [x-shift y-shift].');
        plot_shape(x,y,state);
        x_shifted = x;
        y_shifted = y;
    else
        x_shifted = x+shift(1);
        y_shifted = y+shift(2);
        plot_shape(x_shifted,y_shifted,state);
        return;
    end
    end
end

function [state_projection] = projection(x,y,state)
state_projection =~ state;
plot_shape(x,y,state_projection);
end

function [x_shear,y_shear] = shear_v(x,y,state)
    prompt = 'the shear Factor M = ';
    M = input(prompt);
    x_shear = x ;
    y_shear = M.*x + y;
    plot_shape(x_shear,y_shear,state);
end

function [x_shear,y_shear] = shear_h(x,y,state)
    prompt = 'the shear Factor M = ';
    M = input(prompt);
    x_shear = x + M.*y;
    y_shear = y;
    plot_shape(x_shear,y_shear,state);
end

function [x_scale,y_scale] = scale(x,y,state)
    prompt = ' scale factor S = ';
    S = input(prompt);
    x_scale = S.*x;
    y_scale = S.*y;
    plot_shape(x_scale,y_scale,state);
end

function plot_shape(x,y,state)
if state
    subplot(2,1,2);
    title('modified');fill(x,y,'r');
    axis square;
else
    z=zeros(1,length(x));
    subplot(2,1,2);
    title('modified');fill3(x,y,z,'r');
    axis square;
;
end
end
