#!/usr/bin/env perl

use strict;
use Test::More tests => 14;

use_ok('WWW::Scraper::ISBN::TWBooks_Driver');

ok($WWW::Scraper::ISBN::TWBooks_Driver::VERSION) if $WWW::Scraper::ISBN::TWBooks_Driver::VERSION or 1;

use WWW::Scraper::ISBN;
my $scraper = WWW::Scraper::ISBN->new();
isa_ok($scraper,'WWW::Scraper::ISBN');

$scraper->drivers("TWBooks");
my $isbn = "9864175351";
my $record = $scraper->search($isbn);

SKIP: {
	skip($record->error."\n", 11) unless($record->found);

	is($record->found, 1);
	is($record->found_in, 'TWBooks');

	my $book = $record->book;
	is($book->{'isbn'}, '9864175351');
	is($book->{'title'}, '�Ů������ж}�еL�H�v�������s����');
	is($book->{'author'}, '������B���B��');
	is($book->{'pages'}, '376');
	is($book->{'book_link'}, 'http://www.books.com.tw/exep/prod/booksfile.php?item=0010305457');
	is($book->{'image_link'}, 'http://addons.books.com.tw/G/001/7/0010305457.jpg');
	is($book->{'pubdate'}, '2005 �~ 08 �� 05 ��');
	is($book->{'publisher'}, '�ѤU���');
	is($book->{'price_list'}, '450');
}
