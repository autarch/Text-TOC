use strict;
use warnings;

use Test::Most;

plan skip_all => 'These tests requires HTML::Tidy'
    unless eval { require HTML::Tidy; 1 };

use Path::Class qw( file );
use Text::TOC::HTML;

{
    my $gen = Text::TOC::HTML->new();
    $gen->add_file( file( 't', 'corpus', 'headers.html' ) );

    my $expect_html = <<'EOF';
<ul>
  <li>
    <a href="#H2_A-0">H2 A</a>
    <ul>
      <li>
        <a href="#H3_A-1">H3 A</a>
        <ul>
          <li>
            <a href="#H4_A-2">H4 A</a>
          </li>
        </ul>
      </li>
    </ul>
  </li>
  <li>
    <a href="#H2_B-3">H2 B</a>
  </li>
  <li>
    <a href="#H2_C-4">H2 C</a>
  </li>
  <li>
    <a href="#H2_D-5">H2 D</a>
    <ul>
      <li>
        <ul>
          <li>
            <a href="#H4_B-6">H4 B</a>
          </li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
EOF

    html_output_ok(
        $gen->toc()->innerHTML(),
        $expect_html,
        'unordered list for single-document TOC'
    );
}

{
    my $gen = Text::TOC::HTML->new( style => 'ordered' );
    $gen->add_file( file( 't', 'corpus', 'headers.html' ) );

    my $expect_html = <<'EOF';
<ol>
  <li>
    <a href="#H2_A-0">H2 A</a>
    <ol>
      <li>
        <a href="#H3_A-1">H3 A</a>
        <ol>
          <li>
            <a href="#H4_A-2">H4 A</a>
          </li>
        </ol>
      </li>
    </ol>
  </li>
  <li>
    <a href="#H2_B-3">H2 B</a>
  </li>
  <li>
    <a href="#H2_C-4">H2 C</a>
  </li>
  <li>
    <a href="#H2_D-5">H2 D</a>
    <ol>
      <li>
        <ol>
          <li>
            <a href="#H4_B-6">H4 B</a>
          </li>
        </ol>
      </li>
    </ol>
  </li>
</ol>
EOF

    html_output_ok(
        $gen->toc()->innerHTML(),
        $expect_html,
        'ordered list for single-document TOC'
    );
}

{
    my $gen = Text::TOC::HTML->new( filter => 'multi' );
    $gen->add_file( file( 't', 'corpus', 'headers.html' ) );

    my $expect_html = <<'EOF';

<ul>
  <li>
    <a href="#Page_Title-0">Page Title</a>
  <ul>
    <li>
      <a href="#H2_A-1">H2 A</a>
      <ul>
        <li>
          <a href="#H3_A-2">H3 A</a>
          <ul>
            <li>
              <a href="#H4_A-3">H4 A</a>
            </li>
          </ul>
        </li>
      </ul>
    </li>
    <li>
      <a href="#H2_B-4">H2 B</a>
    </li>
    <li>
      <a href="#H2_C-5">H2 C</a>
    </li>
    <li>
      <a href="#H2_D-6">H2 D</a>
      <ul>
        <li>
          <ul>
            <li>
              <a href="#H4_B-7">H4 B</a>
            </li>
          </ul>
        </li>
      </ul>
    </li>
  </ul>
  </li>
</ul>
EOF

    html_output_ok(
        $gen->toc()->innerHTML(),
        $expect_html,
        'unordered list for multi-document TOC'
    );
}

done_testing();

sub html_output_ok {
    my $got_html    = shift;
    my $expect_html = shift;
    my $desc        = shift;

    my $tidy = HTML::Tidy->new(
        {
            doctype           => 'transitional',
            'sort-attributes' => 'alpha',
        }
    );

    my $real_expect_html = <<"EOF";
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <title></title>
</head>
<body>
$expect_html
</body>
</html>
EOF

    my ($got_body) = $tidy->clean($got_html) =~ m{<body>(.+)</body>}s;
    my ($expect_body)
        = $tidy->clean($real_expect_html) =~ m{<body>(.+)</body>}s;

    eq_or_diff(
        $got_body,
        $expect_body,
        $desc
    );
}
