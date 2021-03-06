#  Copyright 2017 Statoil ASA.
#
#  This file is part of The Open Porous Media project (OPM).
#
#  OPM is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  OPM is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OPM.  If not, see <http://www.gnu.org/licenses/>.
#
#  hhgs@statoil.com

CInfo = riGetActiveCellInfo();
PERMX = riGetActiveCellProperty("PERMX");

# Define a set of boxes with I1 I2 J1 J2 K1 K2 indexes and calculated mean PERMX for each box
boxes(1,:)=[25 29 42 45 17 18];  % Box1 I1 I2 J1 J2 K1 K2 indexes
boxes(2,:)=[30 35 48 55 17 18];	 % Copy rows for more boxes, increase box row index by 1

PERMXAVG=PERMX;
RANGE=PERMX*0;
i=1;

for ijk = boxes'
  # Checks for Main grid = 0
  BOX = (CInfo(:,1) == 0)...					% Checks for main grid
      & (CInfo(:,2) >= ijk(1)) & (CInfo(:,2) <= ijk(2))...  % I1-I2
      & (CInfo(:,3) >= ijk(3)) & (CInfo(:,3) <= ijk(4))...  % J1-J2
      & (CInfo(:,4) >= ijk(5)) & (CInfo(:,4) <= ijk(6));    % K1-K2
  PERMXAVG(BOX) = mean(PERMX(BOX));
  RANGE(BOX) = i;
  i++;
endfor

riSetActiveCellProperty(PERMXAVG, "PERMXAVG");
riSetActiveCellProperty(RANGE, "GRIDBOX");			% Write GRIDBOX, numbering the ranges 1,2,3..


