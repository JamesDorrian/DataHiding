function [Z] = zigzag (quan_block)
    A = quan_block;
    B = double(A);
    ind = reshape(1:numel(B), size(B));         % indices of elements
    ind = fliplr( spdiags( fliplr(ind) ) );     % get the anti-diagonals
    ind(:,1:2:end) = flipud( ind(:,1:2:end) );  % reverse order of odd columns
    ind(ind == 0) = [];                           % keep non-zero indices
    Z = quan_block(ind);                        % get elements in zigzag order
end
