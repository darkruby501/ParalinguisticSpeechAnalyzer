function printmat(a,da,name,rlab,clab,precision)
%PRINTMAT Print matrix with labels.
%   PRINTMAT(A,dA,NAME,RLAB,CLAB) prints the matrix A +/- dA with the row
%   labels RLAB and column labels CLAB.  NAME is a string used to name the
%   matrix.  RLAB and CLAB are cell vectors of strings. Use dA = [] if +/-
%   std value display is not required.

%   Copyright 1986-2012 The MathWorks, Inc.
%   $Revision: 1.1.8.2 $  $Date: 2012/11/01 17:07:56 $
CWS = get(0,'CommandWindowSize');      % max number of char. per line
MaxLength = round(.9*CWS(1));
Labels = nargin>3;
[nrows,ncols] = size(a);
len = 12;    % Max length of labels
Space = ' ';
a(a==0) = 0;  % so that -0 display as 0

% Print name
if ~isempty(name),
   disp([name,' = ']),
end

% Empty case
if (nrows==0) || (ncols==0),
   if (nrows==0) && (ncols==0),
      disp('     []')
   else
      disp(ctrlMsgUtils.message('Control:ltiobject:DispSS7','     ',nrows,ncols));
   end
   disp(' ')
   return
end

% Row labels
if Labels
   RowLabels = strjust(char(' ',rlab{:}),'left');
   RowLabels = RowLabels(:,1:min(len,end));
   RowLabels = [Space(ones(nrows+1,1),ones(3,1)),RowLabels];
else
   lm = repmat(Space,[1 max(find(~isspace(name),1)-2,0)]);
end

% Construct matrix display
Columns = cell(1,ncols);
prec = 3 + isreal(a);
for ct = 1:ncols
   if Labels, clab{ct} = clab{ct}(:,1:min(end,len)); end
   astr = num2str(a(:,ct),prec);
   if ~isempty(da) && any(da(:,ct))
      astr = [astr, repmat(' +/- ',[size(a,1),1]), num2str(da(:,ct),prec)]; %#ok<AGROW>
      Zer = find(da(:,ct)==0);
      for iz = 1:length(Zer)
         I = strfind(astr(Zer(iz),:),'+/-');
         astr(Zer(iz),I:end) = ' ';
      end
   end
   if Labels
      col = [clab(ct); cellstr(deblank(astr))];
   else
      col = cellfun(@(x)[lm,x],cellstr(deblank(astr)),'uni',false);
   end
   col = strrep(col,'+0i','');  % xx+0i->xx
   Columns{ct} = strjust(char(col{:}),'right');
end

% Equalize column width
lc = cellfun('size',Columns,2);
lcmax = max(lc)+2;
for ct = 1:ncols
   if Labels
      Columns{ct} = [Space(ones(nrows+1,1),ones(lcmax-lc(ct),1)), Columns{ct}];
   else
      Columns{ct} = [Space(ones(nrows,1),ones(lcmax-lc(ct),1)), Columns{ct}];
   end
end

% Display MAXCOL columns at a time
if Labels
   maxcol = max(1,round((MaxLength-size(RowLabels,2))/lcmax));
else
   maxcol = max(1,round(MaxLength/lcmax));
end
for ct=1:ceil(ncols/maxcol)
   if Labels
      disp([RowLabels Columns{(ct-1)*maxcol+1:min(ct*maxcol,ncols)}]);
   else
      disp([Columns{(ct-1)*maxcol+1:min(ct*maxcol,ncols)}]);
   end
   disp(' ');
end
