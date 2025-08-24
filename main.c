void kernel_main(){
  char* video = (char*)0xB8000;
  msg = "Welcome to AOS";
  for(int i = 0;msg[i]!='\0';i++){
    video[i*2] = msg[i];
    video[i*2+1] = 0x07;
  }
}
