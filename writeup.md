bugs

Part 2:

 crash1.gft: Firstly, I changed the number of "number_of_gift_card_records" parameter from 1 to -1 to see how the output would change and to see if a segmentation error would take place upon reading the giftcard. I did see changes in the output however, no segmentation error was generated. From reading the giftcardreader file, I saw that there was no check in place to see if the "number_of_gift_card_records" parameter was a positive number or negative. I then changed the value of all the bytes in when the fwrite() function was called to 1 to see if the program would crash. I saw in the giftcardreader.c file there were no checks in place to make sure the byte allocation was correct which is why I tried to exploit this in the giftcardwriter file. 
 
crash2.gft: Secondly, I saw that num_byte was set to a fixed integer of 116 bytes. After reading through the giftcardreader.c file, I saw that this parameter value was being used to allocate memory by called the malloc function. I saw that there were no checks in place to see if the value of this int (number) is negative or positive. So, I exploited this and changed the value to a negative number. This called a segmentation error when running the generated giftcard file as a result of this change. The reason for this is because a negative value of memory cannot be allocated as a result the giftcard file will crash.

crash #3 - I could generate a crash for this however, I did observe that a segmentation error is caused when there is no giftcard (.gft) file provided when running the giftcardreader.c. For instance, when running the following command: ./giftcardreader 1 examplefile.gft. The expected output is printed out on the terminal. However, when examplefile.gft is not provided when there is a segment error seen on the terminal. Again, there is no check in place to see if a file is actually being passed when running the giftcardreader file. 


hang.gft - The hint provided in the assignment indeed did help in this part of the assignment. The record type field was exploit. When calling the animate function by passing the 3 in the record type parameter, I was able to see that the function goes into the while loop. The memory allocation keeps incrementing until the a value of + 256 is passed. Since char is being used to pass negative num due to the program incrementing. The program just hangs and cannot finish executing. Using an unsigned char value would be better in this situation which shall fix the issue. 

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

testing

Part 3:

The code coverage before making any changes (For Part 3) - 52.07%

cov1.c - In order to cover more code, I saw that the type "2" was not being used for the record_type. So on line 39 in the cov1.c, I changed the value from 1 to 2 "examplegcrd.type_of_record = 2" to cover more code. So, this way the record_type:message is being used now. 

The code coverage after making this change - 54.44% (2.37% increase)


cov2.c - In the giftcardreader.c I saw that the animate function also had very less code coverage. The following lines in cov2.c will produce more coverage by passing the following values for each animate use case. 

	unsigned char program[256] = { // using cases 1,2,3,4,6,7,8
		0x01, (10), (12),
		0x02, (10), (12),
		0x04, (10), (12),
		0x06, (10), (12),
		0x07, 0xff, 0xff,
		0x08, 0xff, 0xff,
	};
	fwrite(program, 256, 1, fd1);


The code coverage after making this change - 60.95% (6.51% increase)


After running the fuzzer for more than 15 hours. I saw several crashes and several hangs being generated. I picked a couple of them and saw only a handful of them actually crashes. 

fuzzer1.gft & fuzzer2.gft - I did a lot of debugging with both of them and saw that the program was crashing since there were no checks in place for case 0x01. I observed that both these generated gft files were trying to access memory out of the range of 0 - 16. So, I put an if statement in the giftcardreader.c file on line 32 to check for arg1. After putting that if statement in place. I saw that these 2 gft files and a couple of more gft weren't crashing.


The code coverage after making this change - 68.24% (7.29% increase)


fuzzer3.gft - Upon trying different crash files from the fuzzer, I saw that this file crashed for case 0x04. This was the case because again there was no check in place for the arg1 and arg2 pointers. After adding the if statement on line 47 in the giftcardreader.c file, the gft file didn't crash anymore and did product the expected output. This fix is basically making sure that the arg1 and arg2 values are in the range and below 16.



The code coverage after making this change - 71.18% (2.94% increase)



