// found in internet one-liner in javascript
// that called up for solve problen with acces to
// instagram through tor browser - "csrp serteficate are expires or invalid"
// run in browser console - shift-ctrl-I, console, run.

n = new Date;
t = n.getTime();
et = t + 36E9;
n.setTime(et);
document.cookie=`csrftoken=`+document.body.innerHTML.split(`csrf_token`)[1].split(`\\”`)[2]+`;path=\;domain=.instagram.com;expires=`+n.toUTCString();
