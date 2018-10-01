org 100h

mov bx,10

call getTav 
call checkMinus
call checkDigit
call hishuv
call loop1 

up: call saving
    call backToZiro


call getTav 
call checkMinus
call checkDigit
call hishuv
call loop1  


xx: call saving2 
    call negg
    call math
 
    call checkFlags
    call divNum

   
end: hlt
     ret
        
        
          

getTav:     mov ah,1
            int 21h
            ret
              
checkMinus: cmp al,'-'
            jne sof
            inc flag1
            call getTav            
       sof: ret
       
checkDigit: mov si,0
            cmp al,30h
            jb soff
            cmp al,39h
            ja soff
            inc si
            inc count
      soff: ret 
      
hishuv:     cmp si,0
            je ssof
            sub al,30h
            mov ah,0
            xchg sum,ax
            mov dx,0 
            mul bx 
            add sum,ax
      ssof: ret
        
            
error:      mov ah,9
            lea dx,st
            int 21h
            jmp end
            
            ret
       
loop1:      call getTav
            call checkDigit
            cmp si,1
            je x2
            call checkOoer
       x2:  call checkCount  
            cmp di,0
            je bye
            call hishuv
            jmp loop1
       bye: ret
       
checkCount: mov di,0
            cmp count,5
            je end
            inc di
            ret
   
checkOoer:  cmp flag3,1
            je equal
            cmp al,'+'
            je up          
            cmp al,'-'
            je up
            cmp al,'/'
            je up
            cmp al,'*'
            je up
            call error    
   equal:   cmp al,'='
            je xx
            call error
                  
            ret       

saving:     mov cx,sum 
            mov num1,cx
            mov cl,flag1 
            mov flag2,cl
            mov oper,al
        
            ret
            
backToZiro: mov sum,0
            mov flag1,0
            mov count,0
            inc flag3  
            
            ret 
            
saving2:    mov cx,sum 
            mov num2,cx
  
            ret                  
  

math:       cmp oper,'+'
            je call plus
            cmp oper,'-'
            je call minus
            cmp oper,'*'
            je call multi 
            cmp oper,'/'
            je call diving
            
            ret
            
negg:       cmp oper, '+'
            je x3
            cmp oper, '-' 
            jne sofi
        x3: cmp flag1,0
            je ff
            neg num2
        ff: cmp flag2,0
            je sofi
            neg num1  
             
      sofi: ret      


plus:       mov ax,num1
            add ax,num2
            mov num1,ax 
      
            ret
      
minus:      mov ax,num1
            sub ax,num2 
            mov num1,ax
            
            ret                  
 
multi:      mov ax,num1
            mov bx,num2
            mov dx,0
            mul bx 
            mov num1,ax
            
            ret
              
diving:     mov ax,num1
            mov bx,num2
            mov dx,0
            div bx
            mov num1,ax
            
            ret
            
checkFlags: mov cl,flag1
            add cl,flag2 
            
            cmp cl,1
            jne tt
            cmp oper,'*'
            je call printMinus
            cmp oper,'/'
            je call printMinus          
            
        tt: cmp num1,0
            jge soffi
            neg num1
            call printMinus     
            
  soffi:    ret           
 
printMinus: mov dl,'-'
            mov ah,2
            int 21h
            
            ret
            
divNum:     mov di,0
            mov bx,10000 
   ee:      mov ax,num1
            mov dx,0
            div bx
            mov num1,dx
            call checkTav
            call print
            call divBx 
            cmp bx,0
            jne ee
            jmp end
            
            ret
            
                                                        

checkTav: cmp di,1
          je dd
          cmp al,0
          jne ww 
          jmp dd
          cmp bl,1
          je ww
     ww:  inc di
          
     dd:  ret
     
print:    cmp di,0
          je uu
          mov dl,al 
          add dl,30h
          mov ah,2
          int 21h
          
    uu:   ret
    
divBx: mov ax,bx
       mov bx,10
       mov dx,0
       div bx
       mov bx,ax
       
       ret                

sum   dw 0
num1  dw 0        
num2  dw 0       
count db 0
flag1 db 0
flag2 db 0
flag3 db 0
oper  db 0

st db ' Error, your input is not a digit! $'