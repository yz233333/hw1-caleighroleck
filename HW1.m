% Homework 1. Due before class on 9/5/17

%% Problem 1 - addition with strings

% Fill in the blank space in this section with code that will add 
% the two numbers regardless of variable type. Hint see the matlab
% functions ischar, isnumeric, and str2num. 

%your code should work no matter which of these lines is uncommented. 
x = 3; y = 5; % integers

x = '3'; y= '5'; %strings
x = 3; y = '5'; %mixed

%your code goes here

if ischar(x)
    x = str2num(x);
end

if ischar(y)
    y = str2num(y);
end

new = x + y;

%output your answer

statement = ['The sum of x and y is ' num2str(new)];
disp(statement)

%% Problem 2 - our first real biology problem. Open reading frames and nested loops.

%part 1: write a piece of code that creates a random DNA sequence of length
% N (i.e. consisting of the letters ATGC) where we will start with N=500 base pairs (b.p.).
% store the output in a variable
% called rand_seq. Hint: the function randi may be useful. 
% Even if you have access to the bioinformatics toolbox, 
% do not use the builtin function randseq for this part. 

N = 500; % define sequence length

rand_num = randi(99,[N,1]);
rand_seq = '';
for ii = 1:N
    if rand_num(ii) < 25;
        rand_seq = strcat(rand_seq, 'A');
    elseif (rand_num(ii) <50 & rand_num(ii)>=25);
        rand_seq = strcat(rand_seq, 'T');
    elseif rand_num(ii) >= 50 & rand_num(ii) <75;
        rand_seq = strcat(rand_seq, 'C');
    elseif rand_num(ii) >= 75 & rand_num(ii) <=99;
        rand_seq = strcat(rand_seq,'G');
    end
end
disp(strcat('random sequence: ', rand_seq))
%part 2: open reading frames (ORFs) are pieces of DNA that can be
% transcribed and translated. They start with a start codon (ATG) and end with a
% stop codon (TAA, TGA, or TAG). Write a piece of code that finds the longest ORF 
% in your seqeunce rand_seq. Hint: see the function strfind.

start_codons = strfind(rand_seq, 'ATG');
taa_codons = strfind(rand_seq,'TAA');
tga_codons = strfind(rand_seq, 'TGA');
tag_codons = strfind(rand_seq, 'TAG');
stop_codons = [taa_codons tga_codons tag_codons];
stop_codons = sort(stop_codons);

max_start = 1;
max_stop = 1;
max_length = 0;
longest_seq = '';
[numstart,blank] = size(start_codons);
[numstop, blank2] = size(stop_codons);
for jj = 1:numstart
    for kk = 1:numstop
        if stop_codons(kk) > start_codons(jj)
           length = (stop_codons(kk)+3) - start_codons(jj);
           if rem(length,3) == 0;
               if length > max_length
                   max_length = length;
                   max_start = start_codons(jj);
                   max_stop = stop_codons(kk);
               end
           break
           end
        end
    end
end
if max_length > 0
    longest_seq = rand_seq(max_start:max_stop+2);
end
%part 3: copy your code in parts 1 and 2 but place it inside a loop that
% runs 1000 times. Use this to determine the probability
% that an sequence of length 500 has an ORF of greater than 50 b.p.

long_seq = 0;
for pp = 1:1000
    N = 500; % define sequence length
    rand_num = randi(99,[N,1]);
    rand_seq = '';
    for ii = 1:N
        if rand_num(ii) < 25;
            rand_seq = strcat(rand_seq, 'A');
        elseif (rand_num(ii) <50 & rand_num(ii)>=25);
            rand_seq = strcat(rand_seq, 'T');
        elseif rand_num(ii) >= 50 & rand_num(ii) <75;
            rand_seq = strcat(rand_seq, 'C');
        elseif rand_num(ii) >= 75 & rand_num(ii) <=99;
            rand_seq = strcat(rand_seq,'G');
        end
    end
    start_codons = strfind(rand_seq, 'ATG');
    taa_codons = strfind(rand_seq,'TAA');
    tga_codons = strfind(rand_seq, 'TGA');
    tag_codons = strfind(rand_seq, 'TAG');
    stop_codons = [taa_codons tga_codons tag_codons];
    stop_codons = sort(stop_codons);

    max_start = 1;
    max_stop = 1;
    max_length = 0;
    longest_seq = '';
    [numstart,blank] = size(start_codons);
    [numstop, blank2] = size(stop_codons);
    for jj = 1:numstart
        for kk = 1:numstop
            if stop_codons(kk) > start_codons(jj)
                length = (stop_codons(kk)+3) - start_codons(jj);
                if rem(length,3) == 0;
                    if length > max_length
                         max_length = length;
                         max_start = start_codons(jj);
                         max_stop = stop_codons(kk);
                    end
                break    
                end
            end
        end
    end
    if max_length > 50
        long_seq = long_seq + 1;
    end
end
prob = (long_seq / 10);
disp(['The probability of an ORF > 50 bp: ' num2str(prob) '%'])
%part 4: copy your code from part 3 but put it inside yet another loop,
% this time over the sequence length N. Plot the probability of having an
% ORF > 50 b.p. as a funciton of the sequence length. 

bp_len = [];
N_matrix = [];
for N = 50:500:1000
    long_seq = 0;
    for pp = 1:1000
        rand_num = randi(99,[N,1]);
        rand_seq = '';
        for ii = 1:N
            if rand_num(ii) < 25;
                rand_seq = strcat(rand_seq, 'A');
            elseif (rand_num(ii) <50 & rand_num(ii)>=25);
                rand_seq = strcat(rand_seq, 'T');
            elseif rand_num(ii) >= 50 & rand_num(ii) <75;
                rand_seq = strcat(rand_seq, 'C');
            elseif rand_num(ii) >= 75 & rand_num(ii) <=99;
                rand_seq = strcat(rand_seq,'G');
            end
        end
        start_codons = strfind(rand_seq, 'ATG');
        taa_codons = strfind(rand_seq,'TAA');
        tga_codons = strfind(rand_seq, 'TGA');
        tag_codons = strfind(rand_seq, 'TAG');
        stop_codons = [taa_codons tga_codons tag_codons];
        stop_codons = sort(stop_codons);

        max_start = 1;
        max_stop = 1;
        max_length = 0;
        longest_seq = '';
        [numstart,blank] = size(start_codons);
        [numstop, blank2] = size(stop_codons);
        for jj = 1:numstart
            for kk = 1:numstop
                if stop_codons(kk) > start_codons(jj)
                    length = (stop_codons(kk)+3) - start_codons(jj);
                    if rem(length,3) == 0;
                        if length > max_length
                            max_length = length;
                            max_start = start_codons(jj);
                            max_stop = stop_codons(kk);
                        end
                    break    
                    end
                end
            end
        end
        if max_length > 50
            long_seq = long_seq + 1;
        end
    end
    prob = (long_seq / 10);
    bp_len = [bp_len prob];
    N_matrix = [N_matrix N];
end
figure;
plot(N_matrix,bp_len,'r.');
xlabel('Sequence length (bp)');
ylabel('Probability of ORF length > 50 bp (%)');
%part 5: Make sure your results from part 4 are sensible. What features
% must this curve have (hint: what should be the value when N is small or when
% N is very large? how should the curve change in between?) Make sure your
% plot looks like this. 

% when N is small, the probability should be close to 0
% when N is very large, the probability should be close to 0.5%
% the curve should be noisier at lower values and plateau at 0.5

%% problem 3 data input/output and simple analysis

%The file qPCRdata.txt is an actual file that comes from a Roche
%LightCycler qPCR machine. The important columns are the Cp which tells
%you the cycle of amplification and the position which tells you the well
%from the 96 well plate. Each column of the plate has a different gene and
%each row has a different condition. Each gene in done in triplicates so
%columns 1-3 are the same gene, columns 4-6 the same, etc.
%so A1-A3 are gene 1 condition 1, B1-B3 gene 1 condition 2, A4-A6 gene 2
%condition 1, B4-B6 gene2 condition 2 etc. 

% part1: write code to read the Cp data from this file into a vector. You can ignore the last two
% rows with positions beginning with G and H as there were no samples here. 
clearvars
file = fopen('qPCRdata.txt','r');
line1 = fgetl(file);
cp_data = [];
while line1 ~= -1
   var1 = strsplit(line1, '\t');
   [x,y] = size(var1);
   if y > 6
        assignment = char(var1(1,3));
        if assignment(1) ~= 'G' && assignment(1) ~= 'H'
            try str2double(var1(1,5));
                cp_data = [cp_data str2double(var1(1,5))];
            catch 
                warning('Input must be a character vector or string scalar.');
            end
        end 
   end
   line1 = fgetl(file);
end
cp_data = rmmissing(cp_data);
fclose(file);
% Part 2: transform this vector into an array representing the layout of
% the plate. e.g. a 6 row, 12 column array should that data(1,1) = Cp from
% A1, data(1,2) = Cp from A2, data(2,1) = Cp from B1 etc. 

cp_array = [];
row_counter = 1;
column_counter = 1;
for bb = 1:72
   if bb <= 12
       cp_array = [cp_array cp_data(bb)];
   elseif rem(bb-1,12) == 0
       row_counter = row_counter + 1;
       cp_array(row_counter,1) = cp_data(bb);
       column_counter = 2;
   else
       cp_array(row_counter, column_counter) = cp_data(bb);
       column_counter = column_counter + 1;
   end
end
disp(cp_array)
% Part 3. The 4th gene in columns 10 - 12 is known as a normalization gene.
% That is, it's should not change between conditions and it is used to normalize 
% the expression values for the others. For the other three
% genes, compute their normalized expression in all  conditions, normalized to condition 1. 
% In other words, the fold change between these conditions and condition 1. The
% formula for this is 2^[Cp0 - CpX - (CpN0 - CpNX)] where Cp0 is the Cp for
% the gene in the 1st condition, CpX is the value of Cp in condition X and
% CpN0 and CpNX are the same quantitites for the normalization gene.
% Plot this data in an appropriate way. 

% condition 1 = column 10, etc.
% gene 1 = row 1
% gene 3 = row 3
% rows 5 and 6 are ignored (only need for the other 3 genes)
% in the normalization matrix, column 1 is condition 2, column 2 is
% condition 3
% the rows correspond to gene
for ii = 11:12
    for jj = 1:3
        normalization_matrix(jj,ii-10) = 2^(cp_array(jj,10) - cp_array(jj,ii) - (cp_array(4,10)-cp_array(4,ii)));
    end
end
disp(normalization_matrix)
figure;
c = categorical({'Gene 1','Gene 2','Gene 3'});
foldgraph = bar(c, normalization_matrix);
ylabel('Fold Change')
title('Fold-Change in Respect to Condition 1')
l = cell(1,2)
l{1} = 'Condition 2'; l{2} = 'Condition 3';
legend(foldgraph,l)
%% Challenge problems that extend the above (optional)

% 1. Write a solution to Problem 2 part 2 that doesn't use any loops at
% all. Hint: start by using the built in function bsxfun to make a matrix of all distances
% between start and stop codons. 

% 2. Problem 2, part 4. Use Matlab to compute the exact solution to this
% problem and compare your answer to what you got previously by testing
% many sequences. Plot both on the same set of axes. Hint: to get started 
% think about the following:
% A. How many sequences of length N are there?
% B. How many ways of making an ORF of length N_ORF are there?
% C. For each N_ORF how many ways of position this reading frame in a
% sequence of length N are there?

% 3. Problem 3. Assume that the error in each Cp is the standard deviation
% of the three measurements. Add a section to your code that propogates this
% uncertainty to the final results. Add error bars to your plot. (on
% propagation of error, see, for example:
% https://en.wikipedia.org/wiki/Propagation_of_uncertainty


