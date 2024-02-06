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

mov $start, %rdi
xorq %rax, %rax
call printf

movq $scanf_fmt, %rdi
movq $user_string, %rsi
xorq %rax, %rax
call scanf

call srand
xorq %rax, %rax
call rand
mov $10, %rcx
xor %rdx, %rdx
div %rcx

mov %rdx, %r13
mov $5, %r12

read:
cmp $0, %r12
je time

dec %r12

mov $guess, %rdi
xorq %rax, %rax
call printf

movq $scanf_fmt, %rdi
movq $user_string, %rsi
xorq %rax, %rax
call scanf

cmp %rsi, %r13
je win

mov $no, %rdi
xorq %rax, %rax
call printf
jmp read

win:
mov $yes, %rdi
xorq %rax, %rax
call printf
jmp end

time:
mov $loss, %rdi
mov %r13, %rsi
xorq %rax, %rax
call printf
jmp end

end:
xorq %rax, %rax
movq %rbp, %rsp
popq %rbp
ret
