function U = modifed_U(somMap,recallmap)
    
    %fence
    fence_rowMap = diff(somMap).^2;
    fence_row = sqrt(sum(fence_rowMap,3));
    fence_colMap = diff(somMap,1,2).^2;
    fence_col = sqrt(sum(fence_colMap,3));
    
    max_fence = max([max(fence_col),max(fence_row)]);
    min_fence = min([min(fence_col),min(fence_row)]);
    
    fence_col = (fence_col - min_fence)/(max_fence - min_fence);
    fence_col = [zeros(15,1),fence_col];
    
    fence_row = (fence_row - min_fence)/(max_fence - min_fence);
    fence_row = [zeros(15,1)';fence_row];
    

    density = recallmap/norm(recallmap)*10;

    % red
    red = ones(10,10,225);
    count = 1;

    for i = 1:15
        for j = 1:15
            block(1:8,1:8) = density(j,i);
            block(9:10,:) = fence_row(j,i);
            block(:,9:10) = fence_col(j,i);
            red(:,:,count)=block;
            count = count+1;
        end
    end
    
    RED = [
    red(:,:,1) red(:,:,16) red(:,:,31) red(:,:,46) red(:,:,61) red(:,:,76) red(:,:,91) red(:,:,106) red(:,:,121) red(:,:,136) red(:,:,151) red(:,:,166) red(:,:,181) red(:,:,196) red(:,:,211);
    red(:,:,2) red(:,:,17) red(:,:,32) red(:,:,47) red(:,:,61) red(:,:,77) red(:,:,92) red(:,:,107) red(:,:,122) red(:,:,137) red(:,:,152) red(:,:,167) red(:,:,182) red(:,:,197) red(:,:,212);
    red(:,:,3) red(:,:,18) red(:,:,33) red(:,:,48) red(:,:,63) red(:,:,78) red(:,:,93) red(:,:,108) red(:,:,123) red(:,:,138) red(:,:,153) red(:,:,168) red(:,:,183) red(:,:,198) red(:,:,213);
    red(:,:,4) red(:,:,19) red(:,:,34) red(:,:,49) red(:,:,64) red(:,:,79) red(:,:,94) red(:,:,109) red(:,:,124) red(:,:,139) red(:,:,154) red(:,:,169) red(:,:,184) red(:,:,199) red(:,:,214);
    red(:,:,5) red(:,:,20) red(:,:,35) red(:,:,50) red(:,:,65) red(:,:,80) red(:,:,95) red(:,:,110) red(:,:,125) red(:,:,140) red(:,:,155) red(:,:,170) red(:,:,185) red(:,:,200) red(:,:,215);
    red(:,:,6) red(:,:,21) red(:,:,36) red(:,:,51) red(:,:,66) red(:,:,81) red(:,:,96) red(:,:,111) red(:,:,126) red(:,:,141) red(:,:,156) red(:,:,171) red(:,:,186) red(:,:,201) red(:,:,216);
    red(:,:,7) red(:,:,22) red(:,:,37) red(:,:,52) red(:,:,67) red(:,:,82) red(:,:,97) red(:,:,112) red(:,:,127) red(:,:,142) red(:,:,157) red(:,:,172) red(:,:,187) red(:,:,202) red(:,:,217);
    red(:,:,8) red(:,:,23) red(:,:,38) red(:,:,53) red(:,:,68) red(:,:,83) red(:,:,98) red(:,:,113) red(:,:,128) red(:,:,143) red(:,:,158) red(:,:,173) red(:,:,188) red(:,:,203) red(:,:,218);
    red(:,:,9) red(:,:,24) red(:,:,39) red(:,:,54) red(:,:,69) red(:,:,84) red(:,:,99) red(:,:,114) red(:,:,129) red(:,:,144) red(:,:,159) red(:,:,174) red(:,:,189) red(:,:,204) red(:,:,219);
    red(:,:,10) red(:,:,25) red(:,:,40) red(:,:,55) red(:,:,70) red(:,:,85) red(:,:,100) red(:,:,115) red(:,:,130) red(:,:,145) red(:,:,160) red(:,:,175) red(:,:,190) red(:,:,205) red(:,:,220);
    red(:,:,11) red(:,:,26) red(:,:,41) red(:,:,56) red(:,:,71) red(:,:,86) red(:,:,101) red(:,:,116) red(:,:,131) red(:,:,146) red(:,:,161) red(:,:,176) red(:,:,191) red(:,:,206) red(:,:,221);
    red(:,:,12) red(:,:,27) red(:,:,42) red(:,:,57) red(:,:,72) red(:,:,87) red(:,:,102) red(:,:,117) red(:,:,132) red(:,:,147) red(:,:,162) red(:,:,177) red(:,:,192) red(:,:,207) red(:,:,222);
    red(:,:,13) red(:,:,28) red(:,:,43) red(:,:,58) red(:,:,73) red(:,:,88) red(:,:,103) red(:,:,118) red(:,:,133) red(:,:,148) red(:,:,163) red(:,:,178) red(:,:,193) red(:,:,208) red(:,:,223);
    red(:,:,14) red(:,:,29) red(:,:,44) red(:,:,59) red(:,:,74) red(:,:,89) red(:,:,104) red(:,:,119) red(:,:,134) red(:,:,149) red(:,:,164) red(:,:,179) red(:,:,194) red(:,:,209) red(:,:,224);
    red(:,:,15) red(:,:,30) red(:,:,45) red(:,:,60) red(:,:,75) red(:,:,90) red(:,:,105) red(:,:,120) red(:,:,135) red(:,:,150) red(:,:,165) red(:,:,180) red(:,:,195) red(:,:,210) red(:,:,225)
    ];
    
    
    red = ones(10,10,225);
    count = 1;
    for i = 1:15
        for j = 1:15
            block(1:8,1:8) = 0;
            block(9:10,:) = fence_row(j,i);
            block(:,9:10) = fence_col(j,i);
            red(:,:,count)=block;
            count = count+1;
        end
    end
    
    GREEN = [
    red(:,:,1) red(:,:,16) red(:,:,31) red(:,:,46) red(:,:,61) red(:,:,76) red(:,:,91) red(:,:,106) red(:,:,121) red(:,:,136) red(:,:,151) red(:,:,166) red(:,:,181) red(:,:,196) red(:,:,211);
    red(:,:,2) red(:,:,17) red(:,:,32) red(:,:,47) red(:,:,61) red(:,:,77) red(:,:,92) red(:,:,107) red(:,:,122) red(:,:,137) red(:,:,152) red(:,:,167) red(:,:,182) red(:,:,197) red(:,:,212);
    red(:,:,3) red(:,:,18) red(:,:,33) red(:,:,48) red(:,:,63) red(:,:,78) red(:,:,93) red(:,:,108) red(:,:,123) red(:,:,138) red(:,:,153) red(:,:,168) red(:,:,183) red(:,:,198) red(:,:,213);
    red(:,:,4) red(:,:,19) red(:,:,34) red(:,:,49) red(:,:,64) red(:,:,79) red(:,:,94) red(:,:,109) red(:,:,124) red(:,:,139) red(:,:,154) red(:,:,169) red(:,:,184) red(:,:,199) red(:,:,214);
    red(:,:,5) red(:,:,20) red(:,:,35) red(:,:,50) red(:,:,65) red(:,:,80) red(:,:,95) red(:,:,110) red(:,:,125) red(:,:,140) red(:,:,155) red(:,:,170) red(:,:,185) red(:,:,200) red(:,:,215);
    red(:,:,6) red(:,:,21) red(:,:,36) red(:,:,51) red(:,:,66) red(:,:,81) red(:,:,96) red(:,:,111) red(:,:,126) red(:,:,141) red(:,:,156) red(:,:,171) red(:,:,186) red(:,:,201) red(:,:,216);
    red(:,:,7) red(:,:,22) red(:,:,37) red(:,:,52) red(:,:,67) red(:,:,82) red(:,:,97) red(:,:,112) red(:,:,127) red(:,:,142) red(:,:,157) red(:,:,172) red(:,:,187) red(:,:,202) red(:,:,217);
    red(:,:,8) red(:,:,23) red(:,:,38) red(:,:,53) red(:,:,68) red(:,:,83) red(:,:,98) red(:,:,113) red(:,:,128) red(:,:,143) red(:,:,158) red(:,:,173) red(:,:,188) red(:,:,203) red(:,:,218);
    red(:,:,9) red(:,:,24) red(:,:,39) red(:,:,54) red(:,:,69) red(:,:,84) red(:,:,99) red(:,:,114) red(:,:,129) red(:,:,144) red(:,:,159) red(:,:,174) red(:,:,189) red(:,:,204) red(:,:,219);
    red(:,:,10) red(:,:,25) red(:,:,40) red(:,:,55) red(:,:,70) red(:,:,85) red(:,:,100) red(:,:,115) red(:,:,130) red(:,:,145) red(:,:,160) red(:,:,175) red(:,:,190) red(:,:,205) red(:,:,220);
    red(:,:,11) red(:,:,26) red(:,:,41) red(:,:,56) red(:,:,71) red(:,:,86) red(:,:,101) red(:,:,116) red(:,:,131) red(:,:,146) red(:,:,161) red(:,:,176) red(:,:,191) red(:,:,206) red(:,:,221);
    red(:,:,12) red(:,:,27) red(:,:,42) red(:,:,57) red(:,:,72) red(:,:,87) red(:,:,102) red(:,:,117) red(:,:,132) red(:,:,147) red(:,:,162) red(:,:,177) red(:,:,192) red(:,:,207) red(:,:,222);
    red(:,:,13) red(:,:,28) red(:,:,43) red(:,:,58) red(:,:,73) red(:,:,88) red(:,:,103) red(:,:,118) red(:,:,133) red(:,:,148) red(:,:,163) red(:,:,178) red(:,:,193) red(:,:,208) red(:,:,223);
    red(:,:,14) red(:,:,29) red(:,:,44) red(:,:,59) red(:,:,74) red(:,:,89) red(:,:,104) red(:,:,119) red(:,:,134) red(:,:,149) red(:,:,164) red(:,:,179) red(:,:,194) red(:,:,209) red(:,:,224);
    red(:,:,15) red(:,:,30) red(:,:,45) red(:,:,60) red(:,:,75) red(:,:,90) red(:,:,105) red(:,:,120) red(:,:,135) red(:,:,150) red(:,:,165) red(:,:,180) red(:,:,195) red(:,:,210) red(:,:,225)
    ];
    
    
    U = zeros(150,150,3);
    U(:,:,1)= RED;
    U(:,:,2)= GREEN;
    U(:,:,3)= GREEN;
end