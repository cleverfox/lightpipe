#!/usr/local/bin/perl
use v5.10;

my $dc=0;
for(0..255){
    my $v=0;
    if($_<241){
        if($_ % 5 == 0){ #pad
            $v=-1;
        }else{
            $v=$dc;
            $dc++;
        }
    }elsif($_<251){
        $v=-2;
    }elsif($_==251){
        $v=-1;
    }else{
        $v=0xffff;
    }
    if($v==-2){
        printf("8'h%02x: out <= 0;\n",$_);
    }elsif($v==-1){
        printf("8'h%02x: out <= 1;\n",$_);
    }elsif($_>=252){
        printf("8'h%02x: out <= user[%d];\n",$_,$_-252);
    }else{
        printf("8'h%02x: out <= chan%d[%d];\n",$_,($v/24)+1,$v%24);
    }
}
