function final_project ()

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
%     ************************************************************
    while true 
    prompt = ('select the oepration : \n 1) rotate CCW \n 2) rotate CC\n 3) flip horizontal\n 4) flip vertical \n :  ');
    operation = input(prompt);
    switch operation 
        case 1
            [x, y] = rotate_90_ccw(x,y);
        case 2
            [x, y] = rotate_90_cc(x,y);
        case 3
            [x,y] = flip_h(x,y);
        case 4
            [x,y] = flip_v(x,y);
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