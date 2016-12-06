function final_project ()
    while true
    prompt = ' 1) draw shape \n 2) import image \n 0) to exit \n : ';
    select = input(prompt);
    
    switch select 
        case 0
            clc;
            return;   
        case 1
             draw_shape();
        case 2
            import_image();
    end
    end
%     ************************************************************
end 

function import_image ()
    prompt = ('enter the name of image : ');
    name_of_image = input(prompt);
    image_matrix = imread(name_of_image);
    image(image_matrix);
    while true
        prompt = ('select the oepration : \n 1) rotate CCW \n 2) rotate CC\n 3) flip horizontal\n 4) flip vertical \n 5) rotate by angle\n 0) to exit \n :  ');
        operation = input(prompt);
        switch operation 
            case 0 
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
    prompt = 'Enter number of sides : ';
    num_of_sides = input(prompt);
        for i = 1:num_of_sides 
       fprintf('enter the vertics %d',i);
       prompt = (' :');
       position = input(prompt);
       x(1,i) = position(1,1);
       y(1,i) = position(1,2);
        end
    x(1,num_of_sides+1) = x(1,1);
    y(1,num_of_sides+1) = y(1,1);
    subplot(3,1,1); 
    plot(x, y, 'b-', 'LineWidth', 3);
%     ****************************************************
    while true 
    prompt = ('select the oepration : \n 1) rotate CCW \n 2) rotate CC\n 3) flip horizontal\n 4) flip vertical \n 5) rotate by angle \n 6) shift\n 0) to exit \n :  ');
    operation = input(prompt);
    switch operation 
        case 0 
            return;
        case 1
            [x, y] = rotate_90_ccw(x,y);
        case 2
            [x, y] = rotate_90_cc(x,y);
        case 3
            [x,y] = flip_h(x,y);
        case 4
            [x,y] = flip_v(x,y);
        case 5
            [x,y] = rotate(x,y);
        case 6 
            [x,y] = shift(x,y)
        end
        
    end
end

function [x_rot,y_rot] =  rotate_90_ccw (x,y)
    x_rot = -1.*y;
    y_rot = x;
    subplot(3,1,2);
    plot(x_rot, y_rot, 'b-', 'LineWidth', 3);
end

function [x_rot,y_rot] = rotate_90_cc (x,y) 
    x_rot = y;
    y_rot = -1.*x;
    subplot(3,1,2);
    plot(x_rot, y_rot, 'b-', 'LineWidth', 3);
end

function [x_flip,y_flip] = flip_h(x,y)
   x_flip = -1.*x;
   y_flip = y;
   subplot(3,1,2);
   plot(x_flip,y_flip, 'b-', 'LineWidth', 3);
end

function [x_flip,y_flip] = flip_v(x,y)
   x_flip = x;
   y_flip = -1.*y;
   subplot(3,1,2);
   plot(x_flip,y_flip, 'b-', 'LineWidth', 3);
end

function [x_rot_g,y_rot_g] = rotate (x,y)
    prompt = 'enter the angle : ';
    angle = input(prompt);
    x_rot_g = cosd(angle).*x + sind(angle).*y;
    y_rot_g = -sind(angle).*x + cosd(angle).*y ;
    subplot(3,1,2);
    plot(x_rot_g,y_rot_g, 'b-', 'LineWidth', 3);
end

function [x_shifted,y_shifted] = shift(x,y,shift)
    prompt = 'enter the shift value : ';
    shift = input(prompt);
    x_shifted = x+shift(1);
    y_shifted = y+shift(2);
    subplot(3,1,2);
    plot(x_shifted,y_shifted, 'b-', 'LineWidth', 3);
end