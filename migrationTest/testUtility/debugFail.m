function out = debugFail(a, b)


    sizeTest = migrationTestUtility_dimensionTest(mirgetdata(a),b.getdata);
   
   if  sizeTest == 1
       disp('dimension OK');
       
        x = (mirgetdata(a));
        y = (b.getdata);
        x = x(:);
        y = y(:);
        %res = [x, y,abs(x - y) ];
        maxDiff = (max(abs(x - y)));
        cprintf('*Yellow',['absolute maximum data difference: ', num2str(maxDiff), '\n']);
   else
       disp('dimension fail');   
       cprintf("\tdimension in mirtoolbox \t:") ;
       disp(size(mirgetdata(a)));
       cprintf("\tdimension in miningsuite \t:") ;
       disp(size(b.getdata));
   end
end