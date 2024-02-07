/* 209373000 Yuval Barak */
.extern printf
.extern scanf
.extern rand
.extern srand
.section .data
user_string:
    .space 255, 0x0

.section .rodata
start:
.string "Enter configuration seed: "
guess:
.string "What is your guess? "
yes:
    .string "Congratz! You won!"
no:
    .string "Incorrect. \n"
loss:
 .string "Game over, you lost :(. The Correct answer was %d"

 scanf_fmt:
     .string "%d"

.section .text
.globl	main
.type	main, @function

main:
# Enter
pushq %rbp
movq %rsp, %rbp
# print the message to get the seed
mov $start, %rdi
xorq %rax, %rax
call printf
# get the seed
movq $scanf_fmt, %rdi
movq $user_string, %rsi
xorq %rax, %rax
call scanf
# call sran with teh seed
movq %rsi, %rdi
call srand
xorq %rax, %rax
call rand
# mod 10 the result and save in r13
mov $10, %rcx
xor %rdx, %rdx
div %rcx
mov %rdx, %r13
# intilaize the loop index
mov $5, %r12
jmp read

read:
# if the user pass 5 tries, the game end
cmp $0, %r12
je time
# minus 1 the index
dec %r12
# print the message to guess
mov $guess, %rdi
xorq %rax, %rax
call printf
# get the guess
movq $scanf_fmt, %rdi
movq $user_string, %rsi
xorq %rax, %rax
call scanf
# if the guess right - win the game
cmp %rsi, %r13
je win
# if no, try again
mov $no, %rdi
xorq %rax, %rax
call printf
jmp read

win:
# message of winning
mov $yes, %rdi
xorq %rax, %rax
call printf
jmp end

time:
# message of loss the game
mov $loss, %rdi
mov %r13, %rsi
xorq %rax, %rax
call printf
jmp end

end:
# end the function
xorq %rax, %rax
movq %rbp, %rsp
popq %rbp
ret
